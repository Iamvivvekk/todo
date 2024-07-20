import 'package:flutter/material.dart';
import 'package:todo/themes.dart';

TextStyle normalBlackText({double fontSize = 14}) => TextStyle(
      fontSize: fontSize,
      color: AppTheme.blackColor,
    );

TextStyle normalWhiteText({double fontSize = 14}) => TextStyle(
      fontSize: fontSize,
      color: AppTheme.whiteColor,
    );

TextStyle mediumBoldText({
  double fontSize = 18,
  Color fontColor = Colors.black,
}) =>
    TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: fontColor,
    );

TextStyle boldText({
  double fontSize = 18,
  Color fontColor = Colors.black,
}) =>
    TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: fontColor,
    );

TextStyle textfieldStyle({double fontSize = 14}) => TextStyle(
      fontSize: fontSize,
      color: AppTheme.blackColor,
      fontWeight: FontWeight.w500,
    );

TextStyle textFieldHintStyle({
  double fontSize = 18,
  Color fontColor = Colors.black45,
}) =>
    TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: fontColor,
    );
