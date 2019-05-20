import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'dart:convert';
import 'package:prs_lib_dart/src/config.dart';

class FinanceApi {
  static balance() async {
    return httpManager.netFetch("${Config.host()}/finance/wallet", null, null,
        new Options(method: "get"));
  }

  static getTransactions({int offset = 0, int limit = 10}) async {
    var res = await httpManager.netFetch(
        "${Config.host()}/finance/transactions?offset=$offset&limit=$limit",
        null,
        null,
        new Options(method: "get"));
    return res;
  }

  static recharge(String amount) async {
    Map payload = {
      'payload': {
        'amount': amount,
      }
    };
    var res = await httpManager.netFetch("${Config.host()}/finance/recharge",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }

  static withdraw(String amount) async {
    Map payload = {
      'payload': {
        'amount': amount,
      }
    };
    var res = await httpManager.netFetch("${Config.host()}/finance/withdraw",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }
}
