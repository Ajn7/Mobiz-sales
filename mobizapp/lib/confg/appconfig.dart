import 'package:flutter/material.dart';
import './sizeconfig.dart';

class AppConfig {
  AppConfig._();

  static const appVersion = "0.9.23";
  static const Map<int, Color> colorTheme = {
    50: Color.fromRGBO(116, 66, 134, .1),
    100: Color.fromRGBO(116, 66, 134, .2),
    200: Color.fromRGBO(116, 66, 134, .3),
    300: Color.fromRGBO(116, 66, 134, .4),
    400: Color.fromRGBO(116, 66, 134, .5),
    500: Color.fromRGBO(116, 66, 134, .6),
    600: Color.fromRGBO(116, 66, 134, .7),
    700: Color.fromRGBO(116, 66, 134, .8),
    800: Color.fromRGBO(116, 66, 134, .9),
    900: Color.fromRGBO(116, 66, 134, 1),
  };

  //if main color theme is changed, make color change in main.dart
  /// Colors
  static const Color colorBasic100 = Color(0xFFF8F8FF);
  static const Color colorPrimary = Color(0xFF4B49AC); //Color(0xFF24685B); //
  static const Color selectionColor = Color(0xFF9d7aaa);

  // static const Color colorPrimary = Color(0xFF699BF7);
  // static const Color colorPrimary = Color(0xFF699BF7);
  //static const Color colorPrimary = Color(0xFF19362d);
  static const Color colorSecondary = Color(0xFF2683d3);
  static const Color colorBasic200 = Color(0xFFd8bfd8);
  static const Color colorBasic300 = Color(0xFFEDF1F7);
  static const Color colorBasic400 = Color(0xFFE4E9F2);
  static const Color colorBasic500 = Color(0xFFC5CEE0);
  static const Color colorBasic600 = Color(0xFF8F9BB3);
  static const Color colorBasic700 = Color(0xFFE6E6FA);
  static const Color colorSuccess = Color(0xFF63BD99);
  static const Color colorInfo = Color(0xFF00A5FF);
  static const Color colorWarning = Color(0xFFF9B700);
  static const Color colorSdatheme = Color(0xFF777EE3);

  // static const Color backgroundColor = Color(0xFFF8F8FF);
  //static const Color backgroundColor = Color(0xFFEDF1F7);
  static const Color backgroundColor = Colors.white;

  //static const Color backgroundColor = Color(0xFFFFFacc);
  static const Color backArrowLightBackground = Colors.black54;

  ///TextColors
  static const Color headingColor = Colors.black;
  static const Color buttonTextColor = Colors.white;

  //static const Color textFieldColor = Color(0xFFe1e7f2);
  static const Color textFieldColor = Color(0xFFE6E6FA);
  static const Color buttonDeactiveColor = Colors.grey;
  static const Color textHeadingColor1 = Colors.blueGrey;
  static const Color textbody1 = Colors.black;
  static const Color textbody2 = Colors.white;
  static const Color textAlert = Colors.red;
  static const Color containerBackground = Color(0xFFffffff);
  static const Color navigationTextColor = Colors.black;
  static const Color connected = Colors.green;
  static const Color disconnected = Colors.red;
  static Color shadowColor = Colors.grey.shade200;
  static const Color medicine = Color(0xFF3FCAF5);
  static const Color liquid = Color(0xFF58C5CC);
  static const Color food = Color(0xFF77BB66);
  static const Color others = Color(0xFFCEB52E);

  static const Color backButtonColor = Colors.white;

  //Colors for showing the criticality of vitals
  static const Color critical = Color(0xFFF1444A);
  static const Color high = Color(0xFFF07C7F);
  static const Color medium = Color(0xFFE78C25);
  static const Color normal = Color(0xFF77BB66);
  static const Color low = Color(0xFF458CCC);
  static const Color attention = Color(0xFFffb300);

  static const Color nfcColor = Color(0xFF056608);
  static const Color admin = Color(0xFF024442);

  ///Fonts
  ///New definitions

  static var headLineSize = 20.0;
  static var headLineWeight = FontWeight.bold;
  static var subTitleSize = 18.0;
  static var subTitleWeight = FontWeight.bold;
  static var subTitle2Size = 15.0;
  static var subTitle2Weight = FontWeight.w500;
  static var paragraphSize = 15.0;
  static var paragraphWeight = FontWeight.normal;
  static var paragraph2Size = 15.0;
  static var paragraph2Weight = FontWeight.normal;
  static var captionSize = 14.0;
  static var captionWeight = FontWeight.normal;
  static var labelSize = 14.0;
  static var labelWeight = FontWeight.bold;

  static Color textColorPrimary1 = Color(0xFF744286);
  static Color textColorBasic1 = Color(0xFF222B45);
  static Color textColorHint1 = Color(0xFF8F9BB3);
  static Color textColorDisabled1 = textColorHint.withOpacity(0.48);
  static Color pvGreen = Color(0xFF744286); // Color(0xFF24685B);
  static Color pvSecondary = Color(0xFF744286); //Color(0xFFB99167);

  /// New definitions end
  static var textHeadlineSize = SizeConfig.safeBlockVertical! * 5;
  static var textSubTitleSize = SizeConfig.safeBlockVertical! * 4;
  static var textSubtitle2Size = SizeConfig.safeBlockVertical! * 3;
  static var textSubtitle3Size = SizeConfig.safeBlockVertical! * 2.2;
  static var textParagraphSize = SizeConfig.safeBlockVertical! * 4;
  static var textParagraph2Size = SizeConfig.safeBlockVertical! * 3;
  static var textCaptionSize = SizeConfig.safeBlockVertical! * 2;
  static var textCaption2Size = SizeConfig.safeBlockVertical! * 1.8;
  static var textCaption3Size = SizeConfig.safeBlockVertical! * 1.5;

  static var textLabelSize = SizeConfig.safeBlockVertical! * 2;
  static var textHeadlineWeight = FontWeight.bold;
  static var textSubTitleWeight = FontWeight.w500;
  static var textSubtitle2Weight = FontWeight.w500;
  static var textParagraphWeight = FontWeight.w300;
  static var textParagraph2Weight = FontWeight.w300;
  static var textCaptionWeight = FontWeight.w300;
  static var textLabelWeight = FontWeight.w600;
  static var textFontFamily = "opensans";

  static Color textColorPrimary = Color(0xFF744286);
  static Color textColorBasic = Color(0xFF222B45);
  static Color textColorHint = Color(0xFF8F9BB3);
  static Color textColorDisabled = textColorHint;
  static Color dashboardIconsColor = Color(0xFF815492);

  //// Icons
  var iconSizeSmall = SizeConfig.safeBlockVertical! * 3;
  var iconSizeMedium = SizeConfig.safeBlockVertical! * 3;
  var iconSizelarge = SizeConfig.safeBlockVertical! * 6;
  var iconSizeExtralarge = SizeConfig.safeBlockVertical! * 8;
////
  ///
  ///

//Nurse Page Colors

  static Color onduty = Color(0xFF3FCAF5);
  static Color offduty = Colors.orange;

  //text colors
  static const Color textBlack = Colors.black;

//schedule Colors

  static const Color morning = Color(0xFF024442);
  static const Color lunch = Colors.orange;
  static const Color afternoon = Colors.red;
  static const Color evening = Color(0xFF3FCAF5);

//Nurse Drug Admin Daily Tabs
  static const Color medicineTab = Color(0xFF90BFF6);
  static const Color liquidTab = Color(0xFFC2D7D8);
  static const Color foodTab = Color(0xFF5EA983);
  static const Color consumablesTab = Color(0xFFFFC038); // EE4848);
  static const Color othersTab = Color(0xFFCEB52E);

  static const symptomsContainerColor = Color(0xFFE8FBCF);
  static const observationContainerColor = Color(0xFFDDEBFC);
  static const ObservationColor = Color(0xFF17A1FA);

//Progrees Indicator Colors
  static const Color veryPoor = Color(0xfffc3200);
  static const Color poor = Color(0xfffd9900);
  static const Color normalProgress = Color(0xff84be00);
  static const Color excellant = Color(0xff029407);

//Trust App
  static const Color admissionTab = Color(0xffD4A8FF);
  static const Color visitorsTab = Color(0xffB0F6C7);
  static const Color residentsTab = Color(0xffFFA7A8);
  static const Color doctorTab = Color(0xffFFD2A7);
  static const Color nurseTab = Color(0xffB9BCFF);
  static const Color mangerRecommentaionTab = Color(0xffF4EBEB);
  static const Color peachFuzz = Color(0xffffbe98); //
  // static const Color primaryClr = Color(0xfffc7c48);

  //Manager App
  static const Color primaryAppClr = Color(0xff00529A);
  static const Color primarySubClr = Color(0xff0094D4);
  static const Color primaryHeading = Color(0xff01224F);
  static const Color primaryBackground = Color(0xffF0F5F7);
  static const Color subHeadingClr = Color(0xff575757);
}
