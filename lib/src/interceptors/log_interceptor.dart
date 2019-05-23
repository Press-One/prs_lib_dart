import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/prs_config.dart';

class LogsInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    if (PRSConfig.isDebug) {
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
    if (PRSConfig.isDebug) {
      if (response != null) {
        print('response parameters: ' + response.toString());
      }
    }
    return response;
  }

  @override
  onError(DioError err) {
    if (PRSConfig.isDebug) {
      print('request error: ' + err.toString());
      print('request error message: ' + err.message ?? "");
    }
    return err;
  }
}
