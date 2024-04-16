const JANCODE_LENGTH = 13;
const REGEX_JANCODE = r'^[0-9]{13,13}$';
const REGEX_ASIN_CODE = r'^[A-z0-9]{10,10}$';

class ProductCodeHelper {
  static final RegExp _regExpJan = new RegExp(REGEX_JANCODE);
  static final RegExp _regExpAsin = new RegExp(REGEX_ASIN_CODE);

  static bool isJanCode(String code) {
    return _regExpJan.hasMatch(code);
  }

  static bool isAsinCode(String code) {
    return _regExpAsin.hasMatch(code);
  }
}
