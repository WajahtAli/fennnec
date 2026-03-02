import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/app.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:http/http.dart' as http;

import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/helpers/gradient_toast.dart';
import 'package:fennac_app/helpers/shared_pref_helper.dart';
import '../../app/constants/app_constants.dart';

class ApiHelper {
  final SharedPreferencesHelper sharedPreferencesHelper = Di()
      .sl<SharedPreferencesHelper>();

  final Duration timeout = const Duration(seconds: 15);

  ApiHelper();

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
      _handleException(e);
      return null;
    }
  }

  // ========================= POST =========================
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    bool requiresAuth = true,
    bool isRefreshToken = false,
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
      return _handleResponse(response, isRefreshToken: isRefreshToken);
    } catch (e) {
      log('🔥 API ERROR: ${e.toString()}');
      throw _handleException(e);
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
      _handleException(e);
      return null;
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
      _handleException(e);
      return null;
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
      _handleException(e);
      return null;
    }
  }

  // ========================= RESPONSE HANDLER =========================
  dynamic _handleResponse(http.Response res, {bool isRefreshToken = false}) {
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
      Map raw = jsonDecode(res.body);
      final message = raw["message"];
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

  // ========================= ERROR HANDLER =========================
  String _handleException(dynamic e) {
    if (e is ApiException) {
      return e.message;
    } else if (e is SocketException) {
      return "No internet connection";
    } else if (e is HttpException) {
      return "Server not reachable";
    } else if (e is FormatException) {
      return "Invalid response format";
    } else {
      return "Unexpected error";
    }
  }

  void _toast(String msg) => VxToast.show(message: msg);

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

  String _prettyJson(String source) {
    try {
      final jsonObj = json.decode(source);
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(jsonObj);
    } catch (_) {
      return source;
    }
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
