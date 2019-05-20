import 'package:dio/dio.dart';
import 'package:prs_lib_dart/src/http_manager.dart';
import 'package:prs_utility_dart/prs_utility_dart.dart';
import 'dart:convert';
import 'package:prs_lib_dart/src/config.dart';

class KeystoreApi {
  static loginByEmail(email, password) async {
    final passwordHash = SignUtility.hashPassword(email, password);

    Map params = {
      'payload': {'email': email, 'passwordHash': passwordHash}
    };

    var res = await httpManager.netFetch(
        "${Config.host()}/keystore/login/email",
        json.encode(params),
        null,
        new Options(method: "post"));
    return res;
  }

  static loginByPhone(phone, code) async {
    Map params = {
      'payload': {'phone': phone, 'code': code}
    };

    var res = await httpManager.netFetch(
        "${Config.host()}/keystore/login/phone",
        json.encode(params),
        null,
        new Options(method: "post"));
    return res;
  }

  static sendSMSCodeByPhone(String phone, String type) async {
    Map payload = {
      'payload': {'phone': phone, 'type': type}
    };
    var res = await httpManager.netFetch("${Config.host()}/sendMessageByPhone",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }

  static sendCodeByEmail(String email) async {
    Map payload = {
      'payload': {'email': email}
    };
    var res = await httpManager.netFetch("${Config.host()}/sendMessageByEmail",
        json.encode(payload), null, new Options(method: "post"));
    return res;
  }

  static signUpByEmail(
      String email, String keystore, String password, String code) async {
    final passwordHash =
        SignUtility.hashPassword(email.toLowerCase(), password);
    Map payload = {
      'payload': {
        'email': email.toLowerCase(),
        'passwordHash': passwordHash,
        'keystore': keystore,
        'code': code
      }
    };
    var res = await httpManager.netFetch(
        "${Config.host()}/keystore/signup/email",
        json.encode(payload),
        null,
        new Options(method: "post"));
    return res;
  }

  static signUpByPhone(
      String phone, String keystore, String password, String code) async {
    Map payload = {
      'payload': {
        'phone': phone,
        'password': password,
        'keystore': keystore,
        'code': code
      }
    };
    var res = await httpManager.netFetch(
        "${Config.host()}/keystore/signup/phone",
        json.encode(payload),
        null,
        new Options(method: "post"));
    return res;
  }

  static changePasswordByEmail(String email, String keystore,
      String oldPassword, String newPassword) async {
    final oldPasswordHash = SignUtility.hashPassword(email, oldPassword);
    final newPasswordHash = SignUtility.hashPassword(email, newPassword);
    Map payload = {
      'payload': {
        'oldPasswordHash': oldPasswordHash,
        'newPasswordHash': newPasswordHash,
        'keystore': keystore,
        'type': 'email'
      }
    };
    var res = await httpManager.netFetch(
        "${Config.host()}/keystore/password",
        json.encode(payload),
        {"Content-Type": "application/json"},
        new Options(method: "put"));
    return res;
  }

  static changePasswordByPhone(
      String keystore, String oldPassword, String newPassword) async {
    Map payload = {
      'payload': {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'keystore': keystore,
        'type': 'phone'
      }
    };
    var res = await httpManager.netFetch(
        "${Config.host()}/keystore/password",
        json.encode(payload),
        {"Content-Type": "application/json"},
        new Options(method: "put"));
    return res;
  }
}
