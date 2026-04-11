import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../helpers/shared_pref_helper.dart';
import '../di_container.dart';
import '../../app/constants/app_constants.dart';

class SocketService {
  SocketService._();

  static late io.Socket _socket;
  static bool _isConnected = false;
  static bool _isInitialized = false;

  /// 🔐 Get Token
  static String? get _authToken {
    try {
      return Di().sl<SharedPreferencesHelper>().getAuthToken();
    } catch (_) {
      return null;
    }
  }

  /// 🌐 Base URL Fix
  static String get _baseUrl => AppConstants.baseUrl.endsWith('/')
      ? AppConstants.baseUrl.substring(0, AppConstants.baseUrl.length - 1)
      : AppConstants.baseUrl;

  /// 🔌 CONNECT
  static void connect() {
    if (_isInitialized && _socket.connected) {
      log('⚡ Socket already connected');
      return;
    }

    if (_isInitialized && !_isConnected) {
      // Socket exists but disconnected, just reconnect
      _socket.connect();
      return;
    }

    final token = _authToken;

    final options = io.OptionBuilder()
        .setTransports(["websocket", "polling"])
        .setPath('/socket.io/')
        .setTimeout(20000)
        .enableReconnection()
        .setReconnectionDelay(2000)
        .setReconnectionDelayMax(10000)
        .setReconnectionAttempts(999999)
        .setExtraHeaders({
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        })
        .setAuth({if (token != null && token.isNotEmpty) 'token': token})
        .enableAutoConnect()
        .build();

    _socket = io.io(_baseUrl, options);
    _isInitialized = true;

    /// ✅ CONNECTION EVENTS
    _socket.onConnect((_) {
      _isConnected = true;
      log('✅ Socket connected');
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      log('⚠️ Socket disconnected');
    });

    _socket.onConnectError((err) {
      _isConnected = false;
      log('❌ Connect error: $err');
    });

    _socket.onError((err) {
      _isConnected = false;
      log('❌ Socket error: $err');
    });

    _socket.onReconnect((_) {
      log('🔄 Reconnected');
    });

    _socket.onAny((event, data) {
      log('📩 [$event] => $data');
    });
  }

  /// ❌ DISCONNECT
  static void disconnect() {
    if (!_isInitialized) return;

    log("🧹 Disconnecting socket...");
    _socket.dispose();

    _isInitialized = false;
    _isConnected = false;
  }

  /// 📡 CONNECTION STATUS
  static bool get isConnected => _isConnected;

  /// 🎧 GENERIC LISTENER
  static void on(String event, Function(dynamic data) handler) {
    if (!_isInitialized) connect();

    _socket.off(event); // avoid duplicates
    _socket.on(event, handler);
  }

  /// 🔕 REMOVE LISTENER
  static void off(String event) {
    if (!_isInitialized) return;
    _socket.off(event);
  }

  /// 📤 EMIT EVENT
  static void emit(String event, dynamic data) {
    if (_isConnected) {
      _socket.emit(event, data);
    } else {
      log("❌ Cannot emit, socket not connected");
    }
  }

  /// 🧹 CLEAR ALL LISTENERS
  static void clearAllListeners() {
    if (!_isInitialized) return;
    _socket.clearListeners();
  }

  /// 🔄 RECONNECT WITH NEW TOKEN
  static void reconnectWithNewToken(String token) {
    if (!_isInitialized) return;

    _socket.io.options?['extraHeaders'] = {'Authorization': 'Bearer $token'};

    _socket.disconnect();
    _socket.connect();
  }
}
