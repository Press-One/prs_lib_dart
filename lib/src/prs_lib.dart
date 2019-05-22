import 'prs_config.dart';

class PRSLib {
  static configure(
      {bool isDebug,
      Environment env,
      String token,
      String privateKey,
      String address}) {
    if (isDebug != null) {
      PRSConfig.isDebug = isDebug;
    }
    if (env != null) {
      PRSConfig.env = env;
    }
    if (token != null) {
      PRSConfig.token = token;
      PRSConfig.privateKey = privateKey;
      PRSConfig.address = address;
    }
  }
}
