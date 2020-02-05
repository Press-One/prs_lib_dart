import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'dart:convert';
import 'package:prs_lib_dart/src/prs_config.dart';

class FinanceApi {
  static balance() async {
    return httpManager.netFetch("${PRSConfig.host()}/finance/wallet", null,
        null, new Options(method: "get"));
  }

  static getTransactions({int offset = 0, int limit = 10}) async {
    var res = await httpManager.netFetch(
        "${PRSConfig.host()}/finance/transactions?offset=$offset&limit=$limit",
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
    var res = await httpManager.netFetch("${PRSConfig.host()}/finance/recharge",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }

  static withdraw(String amount, {String phone, String verifyCode}) async {
    Map payload = {
      'payload': {
        'amount': amount,
      }
    };
    Map<String, dynamic> header;
    if (phone != null && verifyCode != null) {
      header = {
        "x-po-auth-type": "phone",
        "x-po-auth-phone": phone,
        "x-po-auth-code": verifyCode
      };
    }

    var res = await httpManager.netFetch("${PRSConfig.host()}/finance/withdraw",
        json.encode(payload), header, new Options(method: "post"));
    return res;
  }
}
