class TextConfig {
  TextConfig._();
  static var appName = "Mobiz Sales";
  static var logo = "Assets/Images/logo.png";

  static var usernameId = "User ID ";
  static var passwordCondition =
      "Password should be between 8 and 30 characters long, with at least one uppercase, one lowercase, one numeric, and one special character(@\$!%*#?&).No white space allowed";
  static var indianCurrency = "\u{20B9}";

  static List<String> smsCountryCode = ["+91"];
}
