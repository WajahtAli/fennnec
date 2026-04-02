import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../app/constants/app_constants.dart';

final class SocketService with WidgetsBindingObserver {
  SocketService._();

  static late io.Socket _socket;
  static bool _isConnected = false;
  static bool _isInitialized = false;

  static String get _socketBaseUrl => AppConstants.baseUrl.endsWith('/')
      ? AppConstants.baseUrl.substring(0, AppConstants.baseUrl.length - 1)
      : AppConstants.baseUrl;

  /// 🔥 Chat events that MAY come without payload (fallback triggers)
  static const List<String> _chatEvents = [
    'chatAndCallsUpdated',
    'chat-updated',
    'chat-updates',
    'call-updated',
    'call-updates',
    'poke-chat-started',
  ];

  /// ✅ Actual message events (WITH DATA)
  static const String _groupMessageEvent = 'group:message:new';
  static const String _directMessageEvent = 'direct:message:new';

  // ===========================
  // 🚀 CONNECT
  // ===========================
  static void connect() {
    if (_isInitialized) {
      if (!_isConnected) {
        _socket.connect();
      }
      return;
    }

    final options = io.OptionBuilder()
        .setTransports(["polling", "websocket"])
        .setPath('/socket.io')
        .enableReconnection()
        .setReconnectionDelay(2000)
        .setReconnectionAttempts(999999)
        .enableAutoConnect()
        .build();

    _socket = io.io(_socketBaseUrl, options);
    _isInitialized = true;

    _socket.onConnect((_) {
      _isConnected = true;
      log('✅ Socket connected');
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      log('⚠️ Socket disconnected');
    });

    _socket.onReconnect((_) {
      log('🔄 Socket reconnected');
    });

    _socket.onReconnectAttempt((attempt) {
      log('Reconnection attempt: $attempt');
    });

    _socket.onReconnectError((err) {
      log('Reconnect error: $err');
    });

    /// 🔥 Debug all events
    _socket.onAny((event, data) {
      log('📩 [$event] => $data');
    });

    WidgetsBinding.instance.addObserver(_lifecycleObserver);
  }

  static void connectIfNeeded() {
    connect();
  }

  static bool get isConnected => _isConnected;

  static final _lifecycleObserver = _SocketLifecycleHandler();

  // ===========================
  // 💬 CHAT LISTENERS
  // ===========================

  /// ✅ Listen to NEW MESSAGES (main one you need)
  static void onNewMessage({required Function(dynamic data) onMessage}) {
    if (!_isInitialized) connect();

    /// remove old listeners (avoid duplicates)
    _socket.off(_groupMessageEvent);
    _socket.off(_directMessageEvent);

    _socket.on(_groupMessageEvent, (data) {
      log("📨 Group message received");
      onMessage(data);
    });

    _socket.on(_directMessageEvent, (data) {
      log("📨 Direct message received");
      onMessage(data);
    });
  }

  /// ❌ Stop listening messages
  static void offNewMessage() {
    if (!_isInitialized) return;
    _socket.off(_groupMessageEvent);
    _socket.off(_directMessageEvent);
  }

  /// 🔄 Fallback updates (if backend doesn't send full message)
  static void onChatRelatedUpdate(VoidCallback onUpdate) {
    if (!_isInitialized) connect();

    for (final event in _chatEvents) {
      _socket.off(event);
      _socket.on(event, (_) {
        log("🔄 Chat update event: $event");
        onUpdate();
      });
    }
  }

  static void offChatRelatedUpdate() {
    if (!_isInitialized) return;
    for (final event in _chatEvents) {
      _socket.off(event);
    }
  }

  // ===========================
  // 📍 LOCATION (unchanged)
  // ===========================

  static void userLocation(Map<String, dynamic> data) {
    if (_isInitialized && _isConnected) {
      _socket.emit('userLocation', data);
    } else {
      log("🚫 Cannot emit userLocation: socket not connected");
    }
  }

  static void riderLocation(Function(Map<String, dynamic>) onData) {
    if (!_isInitialized) return;
    _socket.off('riderLocation');
    _socket.on('riderLocation', (data) {
      onData(data);
    });
  }

  static void rideRequest(Function(Map<String, dynamic>) onData) {
    if (!_isInitialized) return;
    _socket.off('rideRequest');
    _socket.on('rideRequest', (data) {
      onData(data);
    });
  }

  // ===========================
  // 🧹 CLEANUP
  // ===========================

  static void disconnect() {
    if (!_isInitialized) return;

    log("🧹 Disconnecting socket...");
    WidgetsBinding.instance.removeObserver(_lifecycleObserver);

    _socket.dispose();

    _isInitialized = false;
    _isConnected = false;
  }
}

// ===========================
// 🔄 APP LIFECYCLE HANDLER
// ===========================
class _SocketLifecycleHandler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!SocketService._isInitialized) return;

    if (state == AppLifecycleState.resumed) {
      if (!SocketService._isConnected) {
        log('▶️ App resumed → reconnect socket');
        SocketService._socket.connect();
      }
    } else if (state == AppLifecycleState.paused) {
      log('⏸ App paused → disconnect socket');
      SocketService._socket.disconnect();
    }
  }
}
