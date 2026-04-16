import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:fennac_app/app/app.dart';
import 'package:fennac_app/app/constants/socket_constants.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/core/sockets/sockets_service.dart';
import 'package:fennac_app/helpers/shared_pref_helper.dart';
import 'package:fennac_app/reusable_widgets/session_dialog.dart';
import '../../app/constants/app_constants.dart';

class ApiHelper {
  final SharedPreferencesHelper sharedPreferencesHelper = Di()
      .sl<SharedPreferencesHelper>();
  static bool _isDeactivatedDialogVisible = false;
  static bool _isDeactivateSocketListenerAttached = false;

  final Duration timeout = const Duration(seconds: 15);

  ApiHelper() {
    _ensureDeactivateSocketListener();
  }

  void _ensureDeactivateSocketListener() {
    if (_isDeactivateSocketListenerAttached) return;

    SocketService.on(SocketEvents.deactivateAccount, (_) {
      _showDeactivatedDialog();
    });
    _isDeactivateSocketListenerAttached = true;
  }

  // ========================= GET =========================
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) async {
    final String? token = sharedPreferencesHelper.getAuthToken();

    final Uri uri = Uri.parse("${AppConstants.baseUrl}$endpoint").replace(
      queryParameters: queryParameters?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    headers ??= {"Accept": "application/json"};

    if (requiresAuth && token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    _printRequestLog(method: "GET", url: uri.toString(), headers: headers);

    try {
      final response = await http.get(uri, headers: headers).timeout(timeout);

      _printResponseLog(uri.toString(), response);
      return _handleResponse(response);
    } catch (e) {
      log('🔥 API ERROR: $e');
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(_handleException(e), 0);
    }
  }

  // ========================= POST =========================
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    bool requiresAuth = true,
    bool isRefreshToken = false,
    bool isLogin = false,
  }) async {
    final String? token = sharedPreferencesHelper.getAuthToken();
    final String url = "${AppConstants.baseUrl}$endpoint";

    headers ??= {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (requiresAuth && token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    final String? encodedBody = body != null ? jsonEncode(body) : null;

    _printRequestLog(
      method: "POST",
      url: url,
      headers: headers,
      body: encodedBody,
    );

    try {
      final response = await http
          .post(Uri.parse(url), headers: headers, body: encodedBody)
          .timeout(timeout);

      _printResponseLog(url, response);
      return _handleResponse(
        response,
        isRefreshToken: isRefreshToken,
        isLogin: isLogin,
      );
    } catch (e) {
      log('🔥 API ERROR: ${e.toString()}');
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(_handleException(e), 0);
    }
  }

  // ========================= PUT =========================
  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    bool requiresAuth = true,
  }) async {
    final String? token = sharedPreferencesHelper.getAuthToken();
    final String url = "${AppConstants.baseUrl}$endpoint";

    headers ??= {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (requiresAuth && token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    final String? encodedBody = body != null ? jsonEncode(body) : null;

    _printRequestLog(
      method: "PUT",
      url: url,
      headers: headers,
      body: encodedBody,
    );

    try {
      final response = await http
          .put(Uri.parse(url), headers: headers, body: encodedBody)
          .timeout(timeout);

      _printResponseLog(url, response);
      return _handleResponse(response);
    } catch (e) {
      log('🔥 API ERROR: $e');
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(_handleException(e), 0);
    }
  }

  // ========================= MULTIPART (File Upload) =========================
  Future<dynamic> uploadFile(
    String endpoint, {
    Map<String, String>? headers,
    required String fileFieldName,
    required String filePath,
    Map<String, String>? additionalFields,
    bool requiresAuth = true,
    Duration? uploadTimeout,
  }) async {
    final String? token = sharedPreferencesHelper.getAuthToken();
    final String url = "${AppConstants.baseUrl}$endpoint";

    headers ??= {"Accept": "application/json"};

    if (requiresAuth && token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    _printRequestLog(
      method: "MULTIPART",
      url: url,
      headers: headers,
      body: "File: $filePath",
    );

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headers);

      final file = File(filePath);
      request.files.add(
        http.MultipartFile(
          fileFieldName,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );

      if (additionalFields != null) {
        request.fields.addAll(additionalFields);
      }

      // Use longer timeout for file uploads (120 seconds instead of 15)
      final fileUploadTimeout = uploadTimeout ?? const Duration(seconds: 120);
      final response = await request.send().timeout(fileUploadTimeout);
      final responseBody = await response.stream.bytesToString();
      final httpResponse = http.Response(
        responseBody,
        response.statusCode,
        request: response.request,
        headers: response.headers,
      );

      _printResponseLog(url, httpResponse);
      return _handleResponse(httpResponse);
    } catch (e) {
      log('🔥 API ERROR: $e');
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(_handleException(e), 0);
    }
  }

  Future<dynamic> uploadFiles(
    String endpoint, {
    Map<String, String>? headers,
    required String fileFieldName,
    required List<String> filePaths,
    Map<String, String>? additionalFields,
    bool requiresAuth = true,
    Duration? uploadTimeout,
  }) async {
    final String? token = sharedPreferencesHelper.getAuthToken();
    final String url = "${AppConstants.baseUrl}$endpoint";

    if (filePaths.isEmpty) {
      throw ApiException("No files selected for upload", 0);
    }

    headers ??= {"Accept": "application/json"};

    if (requiresAuth && token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    _printRequestLog(
      method: "MULTIPART",
      url: url,
      headers: headers,
      body: "Files: ${filePaths.join(', ')}",
    );

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headers);

      for (final filePath in filePaths) {
        request.files.add(
          await http.MultipartFile.fromPath(
            fileFieldName,
            filePath,
            filename: filePath.split('/').last,
          ),
        );
      }

      if (additionalFields != null) {
        request.fields.addAll(additionalFields);
      }

      final fileUploadTimeout = uploadTimeout ?? const Duration(seconds: 120);
      final response = await request.send().timeout(fileUploadTimeout);
      final responseBody = await response.stream.bytesToString();
      final httpResponse = http.Response(
        responseBody,
        response.statusCode,
        request: response.request,
        headers: response.headers,
      );

      _printResponseLog(url, httpResponse);
      return _handleResponse(httpResponse);
    } catch (e) {
      log('🔥 API ERROR: $e');
      if (e is ApiException) {
        rethrow;
      }
      final errorMessage = _handleException(e);
      throw ApiException(errorMessage, 0);
    }
  }

  // ========================= DELETE =========================
  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    bool requiresAuth = true,
  }) async {
    final String? token = sharedPreferencesHelper.getAuthToken();
    final String url = "${AppConstants.baseUrl}$endpoint";

    headers ??= {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (requiresAuth && token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    final String? encodedBody = body != null ? jsonEncode(body) : null;

    _printRequestLog(
      method: "DELETE",
      url: url,
      headers: headers,
      body: encodedBody,
    );

    try {
      final response = await http
          .delete(Uri.parse(url), headers: headers, body: encodedBody)
          .timeout(timeout);

      _printResponseLog(url, response);
      return _handleResponse(response);
    } catch (e) {
      log('🔥 API ERROR: $e');
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(_handleException(e), 0);
    }
  }

  // ========================= RESPONSE HANDLER =========================
  dynamic _handleResponse(
    http.Response res, {
    bool isRefreshToken = false,
    bool isLogin = false,
  }) {
    log("STATUS CODE: ${res.statusCode}");

    if (res.statusCode >= 200 && res.statusCode < 300) {
      log("BODY: ${res.body}");
      return res.body.isNotEmpty ? jsonDecode(res.body) : null;
    }
    //  else if (res.statusCode == 401 && isRefreshToken == true) {
    //   sharedPreferencesHelper.clearAuthToken();
    //   sharedPreferencesHelper.clearUserData();
    //   VxToast.show(message: "Your Session expired. Please log in again.");
    //   AutoRouter.of(
    //     navigatorKey.currentContext!,
    //   ).replaceAll([OnBoardingRoute()]);
    // }
    else {
      log("RAW ERROR BODY: ${res.body}");
      final raw = _safeDecodeJson(res.body);

      if (res.statusCode == 401) {
        _handleDeactivated401(raw);
      }

      // For login endpoint on 400, return raw response so cubit can extract isVerified
      if (isLogin && res.statusCode == 400) {
        log(
          '📥 isLogin=true & 400 status → returning raw response: ${jsonEncode(raw ?? {})}',
        );
        return raw ?? {};
      }

      final message = raw?["message"];
      if (message is List) {
        for (final x in message.reversed) {
          throw ApiException('${x ?? "Something went wrong"}', res.statusCode);
        }
      } else if (message is String) {
        throw ApiException(message, res.statusCode);
      }
      throw ApiException("Something went wrong", res.statusCode);
    }
  }

  Map<String, dynamic>? _safeDecodeJson(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } catch (_) {}
    return null;
  }

  void _handleDeactivated401(Map<String, dynamic>? raw) {
    final message = raw?['message'];
    final normalizedMessage = message is List
        ? message.join(' ').toLowerCase()
        : (message?.toString().toLowerCase() ?? '');

    if (!normalizedMessage.contains('deactivated')) return;
    _showDeactivatedDialog();
  }

  void _showDeactivatedDialog() {
    if (_isDeactivatedDialogVisible) return;

    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    _isDeactivatedDialogVisible = true;
    showAccountDeactivatedDialog(
      context,
      onDialogClosed: () {
        _isDeactivatedDialogVisible = false;
      },
    );
  }

  // ========================= ERROR HANDLER =========================
  String _handleException(dynamic e) {
    if (e is ApiException) {
      return e.message;
    } else if (e is TimeoutException) {
      return "Request timed out. Please check your internet connection and try again.";
    } else if (e is SocketException) {
      final details = e.message.trim();
      if (details.isEmpty) {
        return "Network error. Please try again.";
      }
      return "Network error: $details";
    } else if (e is http.ClientException) {
      final clientMessage = e.message.trim();
      if (clientMessage.isEmpty) {
        return "Network request failed";
      }
      return "Network request failed: $clientMessage";
    } else if (e is HttpException) {
      return "Server not reachable";
    } else if (e is FormatException) {
      return "Invalid response format";
    } else {
      return "Unexpected error";
    }
  }

  // ========================= LOGGING =========================
  void _printRequestLog({
    required String method,
    required String url,
    Map<String, String>? headers,
    Object? body,
  }) {
    printWrapped('''
==================== 📤 API REQUEST ====================
METHOD: $method
URL: $url
HEADERS: ${jsonEncode(headers)}
BODY: ${body ?? "null"}
========================================================
''');
  }

  void _printResponseLog(String url, http.Response res) {
    printWrapped('''
==================== 📥 API RESPONSE ====================
URL: $url
STATUS: ${res.statusCode}
========================================================
''');
    // BODY: ${_prettyJson(res.body)}
  }

  void printWrapped(String text, {int width = 300}) {
    final pattern = RegExp('.{1,$width}(\n|\$)', dotAll: true);
    for (final match in pattern.allMatches(text)) {
      log(match.group(0) ?? "");
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}
