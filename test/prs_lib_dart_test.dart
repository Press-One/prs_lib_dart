import 'package:flutter_test/flutter_test.dart';

import 'package:prs_lib_dart/prs_lib_dart.dart';
import 'package:flutter/services.dart';
import 'package:prs_lib_dart/src/prs_config.dart';
import 'package:prs_lib_dart/src/prs_lib.dart';

void main() {
  test('keystore', () async {
    final res = await KeystoreApi.loginByEmail('foundation@163.com', '123123');
    print(res.data);
  });

  test('file', () async {
    PRSLib.configure(
        privateKey:
            '1015a0a0857b55b56045b2e082612aca888823d5bf3cd12eec9dba0c4b75fbec',
        token:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1NTg0MDE5NjMsImp0aSI6IjcyNTczZDJhLTAyMmItNDliZS1hZWI0LTdiYzM1NDgyNGE5MiIsImRhdGEiOnsiYWRkcmVzcyI6IjQ0NzQ1OTA1N2IyNzhiNmE3MmRmYjdkYzM1YWE3OWRhZTA3NjQyYWMifSwiYXV0aFR5cGUiOiJlbWFpbCIsInByb3ZpZGVyIjoicHJlc3NvbmUiLCJleHAiOjE1NTg2NjExNjN9.HRZbvBibFK_7WhIfspfiPZ9Kip9CeojnZ81GukFj4cA',
        address: '447459057b278b6a72dfb7dc35aa79dae07642ac');

    final res =
        await FileApi.getFiles('447459057b278b6a72dfb7dc35aa79dae07642ac');
    print(res.data);
  });

  setUpAll(() {
    PRSLib.configure(isDebug: true, env: Environment.prod);

    MethodChannel channel =
        const MethodChannel('plugins.flutter.io/connectivity');
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'check') {
        return 'wifi';
      }
      return null;
    });
  });
}
