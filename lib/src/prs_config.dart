enum Environment { prod, dev }

class PRSConfig {
  static bool isDebug = false;
  static Environment env = Environment.prod;
  static String token;
  static String privateKey;
  static String address;

  static String host() {
    if (env == Environment.prod) {
      return 'https://press.one/api/v2';
    } else {
      return 'https://beta.press.one/api/v2';
    }
  }
}
