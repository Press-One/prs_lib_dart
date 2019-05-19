import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/network_status_code.dart';
import 'package:prs_lib_dart/src/prs_response.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    RequestOptions option = response.request;
    print(response.data);
    try {
      if (option.contentType != null &&
          option.contentType.primaryType == "text") {
        return new PRSResponse(response.data, true, NetworkStatusCode.SUCCESS);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return new PRSResponse(response.data, true, NetworkStatusCode.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + option.path);
      return new PRSResponse(response.data, false, response.statusCode,
          headers: response.headers);
    }
  }
}
