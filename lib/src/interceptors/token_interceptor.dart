import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:prs_lib_dart/src/prs_config.dart';
import 'package:prs_utility_dart/prs_utility_dart.dart';

class TokenInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    if (options.path.contains('finance/wallet') ||
        options.path.contains('finance/transactions') ||
        options.path.contains('finance/recharge') ||
        options.path.contains('finance/withdraw') ||
        options.path.contains('apps') ||
        options.path.contains('users') ||
        options.path.contains('keystore/password') ||
        options.path.contains('sign') ||
        options.path.contains('requestSign') ||
        options.path.contains('tasks') ||
        options.path.contains('contracts') ||
        options.path.contains('orders')) {
      final address = PRSConfig.address;
      if (address != null) {
        var token = PRSConfig.token;
        var privateKey = PRSConfig.privateKey;
        if (privateKey != null) {
          final index = options.path.indexOf('api/v2');
          final path = options.path.substring(index + 6);
          var hash = SignUtility.calcRequestHash(
              path,
              options.data != null
                  ? json.decode(options.data)['payload']
                  : null);
          var signture = await SignUtility.signHash(hash, privateKey);
          options.headers["X-Po-Auth-Address"] = address;
          options.headers["X-Po-Auth-Sig"] = signture;
          options.headers["X-Po-Auth-Msghash"] = hash;
        } else if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
      }
    }
    return options;
  }
}
