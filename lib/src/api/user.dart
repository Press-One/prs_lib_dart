import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'package:prs_utility_dart/prs_utility_dart.dart';
import 'dart:convert';
import 'package:prs_lib_dart/src/config.dart';

class User {
  static getUser(String address) async {
    var res = await httpManager.netFetch("${Config.host()}/users/$address",
        null, null, new Options(method: "get"));
    return res;
  }

  static updateUser({String name, String title, String bio}) async {
    var data = Map<String, String>();
    if (name != null) {
      data['name'] = name;
    }
    if (title != null) {
      data['title'] = title;
    }
    if (bio != null) {
      data['bio'] = bio;
    }
    Map payload = {'payload': data};
    var res = await httpManager.netFetch("${Config.host()}/users",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }

  static updateUserAvatar(String avatar) async {
    Map payload = {
      'payload': {'avatar': avatar}
    };
    var res = await httpManager.netFetch("${Config.host()}/users/avatar",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }
}
