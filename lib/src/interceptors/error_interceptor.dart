import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/net_status_code.dart';
import 'package:prs_lib_dart/src/net_event.dart';
import 'package:prs_lib_dart/src/net_response.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new NetResponse(
          NetEvent.fireErrorEvent(NetStatusCode.ERROR, "", false),
          false,
          NetStatusCode.ERROR));
    }
    return options;
  }
}
