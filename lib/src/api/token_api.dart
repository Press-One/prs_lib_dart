import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'dart:convert';
import 'package:prs_lib_dart/src/config.dart';

class TokenApi {
  static refreshToken() async {
    Map payload = {
      'payload': {'expiresIn': 60 * 60 * 24 * 7}
    };
    var res = await httpManager.netFetch("${Config.host()}/tokens",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }
}
