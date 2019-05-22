import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'package:prs_lib_dart/src/prs_config.dart';

class DappApi {
  static getMyDApp() async {
    var res = await httpManager.netFetch(
        "${PRSConfig.host()}/apps", null, null, new Options(method: "get"));
    return res;
  }

  static getAuthorizedDApp() async {
    var res = await httpManager.netFetch("${PRSConfig.host()}/apps/authorized",
        null, null, new Options(method: "get"));
    return res;
  }
}
