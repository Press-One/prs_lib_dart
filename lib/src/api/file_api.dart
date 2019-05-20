import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'package:prs_lib_dart/src/config.dart';

class FileApi {
  static getFiles(String address,
      {int offset = 0, int limit = 1, String type}) async {
    var url =
        "${Config.host()}/users/$address/feed.json?offset=$offset&limit=$limit";
    if (type != null) {
      url = url + "&type=$type";
    }
    var res =
        await httpManager.netFetch(url, null, null, new Options(method: "get"));
    return res;
  }

  static getFileByRId(String rId) async {
    var res = await httpManager.netFetch(
        "${Config.host()}/files/$rId", null, null, new Options(method: "get"));
    return res;
  }

  static getFileByMsghash(String msghash) async {
    var res = await httpManager.netFetch("${Config.host()}/files/hash/$msghash",
        null, null, new Options(method: "get"));
    return res;
  }

  static getFileContent(String url) async {
    var res =
        await httpManager.netFetch(url, null, null, new Options(method: "get"));
    return res;
  }
}
