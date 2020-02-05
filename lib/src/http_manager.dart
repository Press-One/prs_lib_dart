import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/net_event.dart';
import 'package:prs_lib_dart/src/net_response.dart';
import 'package:prs_lib_dart/src/interceptors/error_interceptor.dart';
import 'package:prs_lib_dart/src/interceptors/header_interceptor.dart';
import 'package:prs_lib_dart/src/interceptors/log_interceptor.dart';
import 'package:prs_lib_dart/src/interceptors/token_interceptor.dart';
import 'package:prs_lib_dart/src/net_status_code.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio = new Dio();

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();

  HttpManager() {
    _dio.interceptors.add(new HeaderInterceptors());

    _dio.interceptors.add(_tokenInterceptors);

    _dio.interceptors.add(new LogsInterceptors());

    _dio.interceptors.add(new ErrorInterceptors(_dio));
  }

  netFetch(url, params, Map<String, dynamic> header, Options option,
      {noFire = false}) async {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }
    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return _resultError(e, noFire);
    }

    if (response.redirects != null &&
        response.redirects.isNotEmpty &&
        response.redirects[0].location != null &&
        response.redirects[0].location.path == '/hub/login') {
      return NetResponse(NetEvent.fireErrorEvent(403, '', noFire), false, 403,
          headers: response.headers);
    }

    return new NetResponse(response.data, true, response.statusCode,
        headers: response.headers);
  }

  _resultError(DioError e, bool noFire) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = new Response(statusCode: 666);
    }
    if (e.type == DioErrorType.CONNECT_TIMEOUT ||
        e.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorResponse.statusCode = NetStatusCode.TIMEOUT;
    }
    NetEvent.fireErrorEvent(
        errorResponse.statusCode, errorResponse.toString(), noFire);
    return new NetResponse(errorResponse, false, errorResponse.statusCode);
  }
}

final HttpManager httpManager = new HttpManager();
