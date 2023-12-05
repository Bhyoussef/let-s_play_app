import 'package:flutter/material.dart';
import 'package:lets_play/common/constants/constants.dart';

class AppStyles {
  static const largeButtonTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: interFont);

  static const largeButtonTextStyleDisabled = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFFF7E047),
      fontFamily: interFont);

  static TextStyle textButtonTextStyle({double fontSize = 18}) {
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        color: AppColors.yellow,
        fontFamily: interFont);
  }

  static ButtonStyle elevatedButtonDefaultStyle = ElevatedButton.styleFrom(
      surfaceTintColor: AppColors.yellow,
      backgroundColor: AppColors.yellow,
      minimumSize: const Size.fromHeight(60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ));

  static ButtonStyle createMatchStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.purple),
      elevation: MaterialStateProperty.all(8),
      shadowColor: MaterialStateProperty.all(const Color(0xff511E9B)),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))));

  static const inter9w300 = TextStyle(
      fontFamily: interFont, fontSize: 9, fontWeight: FontWeight.w300);
  static const inter15w500 = TextStyle(
      fontFamily: interFont, fontSize: 15, fontWeight: FontWeight.w500);
  static const inter18Bold = TextStyle(
      fontFamily: interFont, fontSize: 18, fontWeight: FontWeight.bold);
  static const inter13w500 = TextStyle(
      fontFamily: interFont, fontSize: 13, fontWeight: FontWeight.w500);
  static const inter13Bold = TextStyle(
      fontFamily: interFont, fontSize: 13, fontWeight: FontWeight.bold);
  static const inter12w500 = TextStyle(
      fontFamily: interFont, fontSize: 12, fontWeight: FontWeight.w500);
  static const inter12w400 = TextStyle(
      fontFamily: interFont, fontSize: 12, fontWeight: FontWeight.w400);
  static const inter17w500 = TextStyle(
      fontFamily: interFont,
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Colors.white);
  static const sf37Bold = TextStyle(
      fontFamily: sfDisplayFont,
      fontSize: 37,
      fontWeight: FontWeight.bold,
      color: Colors.white);
  static const mont12Regular = TextStyle(
      fontFamily: montserratFont,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white);
  static TextStyle sf17Regular = TextStyle(
      fontFamily: sfDisplayFont,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      color: AppColors.purple);
  static const mont19BoldBlack = TextStyle(
      fontFamily: montserratFont,
      fontSize: 19,
      fontWeight: FontWeight.bold,
      color: Colors.black);
  static const mont12RegularBlack = TextStyle(
      fontFamily: montserratFont,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.black);
  static const mont13RegularBlack = TextStyle(
      fontFamily: montserratFont,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.black);
  static const tabbarTextStyle = TextStyle(
      fontFamily: interFont, fontSize: 11, fontWeight: FontWeight.w500);
  static TextStyle tabbarSelectedTextStyle = TextStyle(
      fontFamily: interFont,
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: AppColors.purple);
  static TextStyle mont27bold = TextStyle(
      fontFamily: montserratFont,
      fontSize: 27,
      fontWeight: FontWeight.bold,
      color: AppColors.purple);
  static const mont13Medium = TextStyle(
      fontFamily: montserratFont, fontSize: 13, fontWeight: FontWeight.w500);
  static const mont14Medium = TextStyle(
      fontFamily: montserratFont, fontSize: 14, fontWeight: FontWeight.w500);
  static const mont15Medium = TextStyle(
      fontFamily: montserratFont, fontSize: 15, fontWeight: FontWeight.w500);
  static const mont17Bold = TextStyle(
      fontFamily: montserratFont, fontSize: 17, fontWeight: FontWeight.bold);
  static const inter14w500 = TextStyle(
      fontFamily: interFont, fontSize: 14, fontWeight: FontWeight.w500);
  static const inter17Bold = TextStyle(
      fontFamily: interFont, fontSize: 17, fontWeight: FontWeight.bold);
  static const sf10W500 = TextStyle(
      fontFamily: sfDisplayFont, fontSize: 10, fontWeight: FontWeight.w500);
  static const inter15Bold = TextStyle(
      fontFamily: interFont, fontSize: 15, fontWeight: FontWeight.bold);
  static const inter12Bold = TextStyle(
      fontFamily: interFont, fontSize: 12, fontWeight: FontWeight.bold);
  static const inter20SemiBold = TextStyle(
      fontFamily: interFont, fontSize: 20, fontWeight: FontWeight.w600);
  static const inter13SemiBold = TextStyle(
      fontFamily: interFont, fontSize: 13, fontWeight: FontWeight.w600);
  static const mont10Medium = TextStyle(
      fontFamily: montserratFont, fontSize: 10, fontWeight: FontWeight.w500);
  static const inter11w500 = TextStyle(
      fontFamily: interFont, fontSize: 11, fontWeight: FontWeight.w500);
  static const inter10w500 = TextStyle(
      fontFamily: interFont, fontSize: 10, fontWeight: FontWeight.w500);
  static const mont16Medium = TextStyle(
      fontFamily: montserratFont, fontSize: 16, fontWeight: FontWeight.w500);
  static const mont16Bold = TextStyle(
      fontFamily: montserratFont, fontSize: 16, fontWeight: FontWeight.bold);
  static const sf17Bold = TextStyle(
      fontFamily: sfDisplayFont, fontSize: 17, fontWeight: FontWeight.bold);
  static const sf14W500 = TextStyle(
      fontFamily: sfDisplayFont, fontSize: 14, fontWeight: FontWeight.w500);
  static const sf15Bold = TextStyle(
      fontFamily: sfDisplayFont, fontSize: 15, fontWeight: FontWeight.bold);
  static const mont23Bold = TextStyle(
      fontFamily: montserratFont, fontSize: 23, fontWeight: FontWeight.bold);
  static const mont11Bold = TextStyle(
      fontFamily: montserratFont, fontSize: 11, fontWeight: FontWeight.bold);
  static const mont23SemiBold = TextStyle(
      fontFamily: montserratFont, fontSize: 23, fontWeight: FontWeight.w600);
  static const mont12SemiBold = TextStyle(
      fontFamily: montserratFont, fontSize: 12, fontWeight: FontWeight.w600);
  static const inter15w400 = TextStyle(
      fontFamily: interFont, fontSize: 15, fontWeight: FontWeight.w400);
}

extension HelperTextStyle on TextStyle {
  withColor(Color color) {
    return copyWith(color: color);
  }
}

class AppColors {
  static Color yellow = const Color(0xFFFDE74C);
  static Color yellowDisabled = const Color(0xFFFFF5B1);
  static Color purple = const Color(0xFF511E9B);
  static Color backGrey = const Color(0xFFF4F6F8);
  static Color disabledGrey = const Color(0xFFD1D1D1);
  static Color lightBlue = const Color(0xFFF3F5F7);
  static Color lightPurple = const Color(0xFF9B80C3);
  static Color grey = const Color(0xFFD7DBDE);
  static Color greyText = const Color(0xFF787B7C);
  static Color mainRed = const Color.fromRGBO(247, 75, 97, 1);
}
