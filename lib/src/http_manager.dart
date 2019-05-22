import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/network_status_code.dart';
import 'package:prs_lib_dart/src/network_event.dart';
import 'package:prs_lib_dart/src/prs_response.dart';
import 'package:prs_lib_dart/src/interceptors/error_interceptor.dart';
import 'package:prs_lib_dart/src/interceptors/header_interceptor.dart';
import 'package:prs_lib_dart/src/interceptors/log_interceptor.dart';
import 'package:prs_lib_dart/src/interceptors/response_interceptor.dart';
import 'package:prs_lib_dart/src/interceptors/token_interceptor.dart';

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

    _dio.interceptors.add(new ResponseInterceptors());
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

    resultError(DioError e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = NetworkStatusCode.TIMEOUT;
      }
      return new PRSResponse(
          NetworkEvent.fireErrorEvent(
              errorResponse.statusCode, errorResponse.toString(), noFire),
          false,
          errorResponse.statusCode);
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }
}

final HttpManager httpManager = new HttpManager();
