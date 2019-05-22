import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'dart:convert';
import 'package:prs_lib_dart/src/prs_config.dart';

class SignApi {
  static signBlockData(Map<String, dynamic> data) async {
    Map payload = {
      'payload': {
        'data': data,
      }
    };
    var res = await httpManager.netFetch("${PRSConfig.host()}/sign",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }

  static signRequestSign(String path, Map<String, dynamic> data) async {
    Map payload = {
      'payload': {
        'payload': data,
        'path': path,
      }
    };
    var res = await httpManager.netFetch("${PRSConfig.host()}/requestSign",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }
}
