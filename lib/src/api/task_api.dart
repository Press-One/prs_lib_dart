import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'dart:convert';
import 'package:prs_lib_dart/src/config.dart';

class TaskApi {
  static getMyTasks({int offset = 0, int limit = 10}) async {
    var res = await httpManager.netFetch(
        "${Config.host()}/tasks/accepted?offset=$offset&limit=$limit",
        null,
        null,
        new Options(method: "get"));
    return res;
  }

  static getUnacceptedTasks({int offset = 0, int limit = 10}) async {
    var res = await httpManager.netFetch(
        "${Config.host()}/tasks?filter=UNACCEPTED_POOL&offset=$offset&limit=$limit",
        null,
        null,
        new Options(method: "get"));
    return res;
  }

  static getTaskDetail(int taskId) async {
    var res = await httpManager.netFetch("${Config.host()}/tasks/$taskId", null,
        null, new Options(method: "get"));
    return res;
  }

  static acceptTask(int taskId) async {
    var res = await httpManager.netFetch(
        "${Config.host()}/tasks/$taskId/accepted",
        null,
        null,
        new Options(method: "post"));
    return res;
  }

  static completeTask(int taskId) async {
    Map payload = {
      'payload': {'status': 'FINISHED'}
    };
    var res = await httpManager.netFetch(
        "${Config.host()}/tasks/$taskId/accepted",
        json.encode(payload),
        null,
        new Options(method: "put"));
    return res;
  }

  static remarkTask(int taskId, String remark) async {
    Map payload = {
      'payload': {'remark': remark}
    };
    var res = await httpManager.netFetch(
        "${Config.host()}/tasks/$taskId/accepted",
        json.encode(payload),
        null,
        new Options(method: "put"));
    return res;
  }
}
