import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'package:prs_lib_dart/src/prs_config.dart';

class BlockApi {
  static getBlocks(List<String> rIds) async {
    var res = await httpManager.netFetch(
        "${PRSConfig.host()}/blocks/${rIds.join(',')}?withDetail=true",
        null,
        null,
        new Options(method: "get"));
    return res;
  }
}
