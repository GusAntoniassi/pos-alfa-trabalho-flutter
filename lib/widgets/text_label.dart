import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:aula02bd/constants.dart' as Constants;

class TextLabel {
  static Widget create(String text,
      {color = Constants.PRIMARY_COLOR,
      size: Constants.FONT_SIZE,
      bold: FontWeight.normal}) {
    return Text(text,
        style: TextStyle(color: color, fontSize: size, fontWeight: bold));
  }
}
