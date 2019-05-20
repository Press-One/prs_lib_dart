import 'package:flutter_test/flutter_test.dart';

import 'package:prs_lib_dart/prs_lib_dart.dart';
import 'package:flutter/services.dart';

void main() {
  test('keystore', () async {
    final res = await KeystoreApi.loginByEmail('foundation@163.com', '123123');
    print(res.data);
  });

  setUpAll(() {
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
