import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:prs_lib_dart/prs_lib_dart.dart';
import 'package:flutter/services.dart';
import 'package:prs_lib_dart/src/prs_config.dart';
import 'package:prs_lib_dart/src/prs_lib.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('keystore', () async {
    final res = await KeystoreApi.loginByEmail('foundation@163.com', '123123');
    print(res.data);
  });

  test('contract', () async {
    PRSLib.configure(
        isDebug: true,
        env: Environment.prod,
        privateKey:
            '1015a0a0857b55b56045b2e082612aca888823d5bf3cd12eec9dba0c4b75fbec',
        address: '447459057b278b6a72dfb7dc35aa79dae07642ac');

    final res = await ContractApi.getContracts();

    print(res.code);
    print(res.data);
  });

  test('file', () async {
    PRSLib.configure(
        isDebug: true,
        env: Environment.prod,
        privateKey:
            '1015a0a0857b55b56045b2e082612aca888823d5bf3cd12eec9dba0c4b75fbec',
        address: '447459057b278b6a72dfb7dc35aa79dae07642ac');

    final res =
        await FileApi.getFiles('447459057b278b6a72dfb7dc35aa79dae07642ac');
    // print(res.data);
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
