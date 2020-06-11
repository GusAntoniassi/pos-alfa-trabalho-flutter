import 'package:aula02bd/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'package:aula02bd/constants.dart' as Constants;

class TitleBar {
  static Widget create(String title,
      {Color bgColor = Constants.PRIMARY_COLOR,
      Color textColor = Constants.TEXT_COLOR,
      fontSize = 20.0,
      List<Widget> actions}) {
    return AppBar(
        title: TextLabel.create(title, color: textColor, size: fontSize),
        centerTitle: false,
        backgroundColor: bgColor,
        actions: actions
    );
  }
}
