import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/network_status_code.dart';
import 'package:prs_lib_dart/src/network_event.dart';
import 'package:prs_lib_dart/src/prs_response.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(new PRSResponse(
          NetworkEvent.fireErrorEvent(NetworkStatusCode.ERROR, "", false),
          false,
          NetworkStatusCode.ERROR));
    }
    return options;
  }
}
