import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'package:prs_utility_dart/prs_utility_dart.dart';
import 'dart:convert';
import 'package:prs_lib_dart/src/prs_config.dart';
import 'sign_api.dart';

class ContractApi {
  static getContractTemplates(String type) async {
    var res = await httpManager.netFetch(
        "${PRSConfig.host()}/contracts/templates?type=$type",
        null,
        null,
        new Options(method: "get"));
    return res;
  }

  static getContracts({int offset = 0, int limit = 10}) async {
    var res = await httpManager.netFetch(
        "${PRSConfig.host()}/contracts?offset=$offset&limit=$limit",
        null,
        null,
        new Options(method: "get"));
    return res;
  }

  static createContract(String code) async {
    String codeHash = SignUtility.keecak256String(code);
    final data = {'file_hash': codeHash};
    final hash = SignUtility.calcObjectHash(data);
    var privateKey = PRSConfig.privateKey;
    var token = PRSConfig.token;

    String signature;
    if (privateKey != null) {
      signature = await SignUtility.signHash(hash, privateKey);
    } else if (token != null) {
      final res = await SignApi.signBlockData(data);
      if (res != null && res.result) {
        signature = res.data['signature'] as String;
      }
    }

    Map payload = {
      'payload': {'code': code, 'signature': signature}
    };
    var res = await httpManager.netFetch("${PRSConfig.host()}/contracts",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }

  static bindContract(String contractRId, String fileRId) async {
    final address = PRSConfig.address;
    final data = {
      'beneficiary_address': address,
      'content_id': fileRId,
      'contract_id': contractRId
    };
    final hash = SignUtility.calcObjectHash(data);
    var privateKey = PRSConfig.privateKey;
    var token = PRSConfig.token;

    String signature;
    if (privateKey != null) {
      signature = await SignUtility.signHash(hash, privateKey);
    } else if (token != null) {
      final res = await SignApi.signBlockData(data);
      if (res != null && res.result) {
        signature = res.data['signature'] as String;
      }
    }

    Map payload = {
      'payload': {'fileRId': fileRId, 'signature': signature}
    };
    var res = await httpManager.netFetch(
        "${PRSConfig.host()}/contracts/$contractRId/bind",
        json.encode(payload),
        null,
        new Options(method: "post"));
    return res;
  }

  static getOrders({int offset = 0, int limit = 10}) async {
    var res = await httpManager.netFetch(
        "${PRSConfig.host()}/orders?offset=$offset&limit=$limit",
        null,
        null,
        new Options(method: "get"));
    return res;
  }

  static getContractOrders(String rId, {int offset = 0, int limit = 10}) async {
    var res = await httpManager.netFetch(
        "${PRSConfig.host()}/contracts/$rId/orders?offset=$offset&limit=$limit",
        null,
        null,
        new Options(method: "get"));
    return res;
  }
}
