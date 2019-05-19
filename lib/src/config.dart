enum Environment { prod, dev }

class Config {
  static bool isDebug = false;
  static Environment env = Environment.prod;
  static String token;
  static String privateKey;
  static String address;

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

  static String host() {
    if (env == Environment.prod) {
      return 'https://press.one/api/v2';
    } else {
      return 'https://beta.press.one/api/v2';
    }
  }
}
