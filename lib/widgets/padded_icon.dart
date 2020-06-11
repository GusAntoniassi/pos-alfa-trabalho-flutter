import 'package:flutter/material.dart';
import 'package:aula02bd/constants.dart' as Constants;

class PaddedIcon {
  static Widget create(IconData icon,
      {Color textColor,
      double fontSize = Constants.FONT_SIZE,
      left = 0.0,
      top = 0.0,
      right = 8.0,
      bottom = 0.0}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Icon(icon, color: textColor, size: fontSize),
    );
  }
}
