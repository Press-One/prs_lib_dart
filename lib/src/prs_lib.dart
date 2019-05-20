import 'config.dart';

class PRSLib {
  static configure(
      {bool isDebug,
      Environment env,
      String token,
      String privateKey,
      String address}) {
    if (isDebug != null) {
      Config.isDebug = isDebug;
    }
    if (env != null) {
      Config.env = env;
    }
    if (token != null) {
      Config.token = token;
    }
    if (privateKey != null) {
      Config.privateKey = privateKey;
    }
    if (address != null) {
      Config.address = address;
    }
  }
}
