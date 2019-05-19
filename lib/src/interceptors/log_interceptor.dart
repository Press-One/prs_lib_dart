import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/config.dart';

class LogsInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    if (Config.isDebug) {
      print("requset url: ${options.path}");
      print('requset header: ' + options.headers.toString());
      if (options.data != null) {
        print('request parameters: ' + options.data);
      }
    }
    return options;
  }

  @override
  onResponse(Response response) {
    if (Config.isDebug) {
      if (response != null) {
        print('response parameters: ' + response.toString());
      }
    }
    return response; // continue
  }

  @override
  onError(DioError err) {
    if (Config.isDebug) {
      print('request error: ' + err.toString());
      print('request error message: ' + err.response?.toString() ?? "");
    }
    return err;
  }
}
