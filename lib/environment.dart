// ignore_for_file: constant_identifier_names

class Environment {
  static const appName = "NB Bank";
  static const appVersion = "1.0.0";

  static String defaultLangCode = "en";
  static String defaultLanguageName = "English";

  static String defaultPhoneDialCode = "1"; //don't put + here
  static String defaultCountryCode = "US";
  static int maxMobileNumberDigit = 10; // Specify the required mobile number digits without country code
  static int maxPinNumberDigit = 5; // Specify the required max pin number digits
  static int maxAllowPrecision = 10; // Specify the required allow precision for amount of digits

  static const int otpResendDuration = 120;
  static const bool IS_COLOR_FROM_INTERNET = false;

  static const bool ENABLE_ONBOARD = true;
  static const bool DEV_MODE = false;

  static const MAIN_API_URL = DEV_MODE ? TEST_API_URL : LIVE_API_URL; // Don't touch here
  static const LIVE_API_URL = 'https://antiquewhite-anteater-348440.hostingersite.com';
  static const TEST_API_URL = 'https://antiquewhite-anteater-348440.hostingersite.com'; //Local or demo or test URL
}
