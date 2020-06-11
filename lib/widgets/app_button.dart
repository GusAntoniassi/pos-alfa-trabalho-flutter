import 'package:aula02bd/widgets/padded_icon.dart';
import 'package:aula02bd/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'package:aula02bd/constants.dart' as Constants;

class AppButton {
  static Widget create(String text, Function callback,
      {Color bgColor = Constants.PRIMARY_COLOR,
      Color textColor = Constants.TEXT_COLOR,
      double left = 20.0,
      double top = 10.0,
      double right = 20.0,
      double bottom = 10.0,
      IconData icon,
      double buttonSize = 150.0,
      double fontSize = Constants.FONT_SIZE}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: RaisedButton(
          color: bgColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon != null
                  ? PaddedIcon.create(icon,
                      textColor: textColor, fontSize: fontSize)
                  : Container(),
              TextLabel.create(text, color: textColor, size: fontSize),
            ],
          ),
          onPressed: callback,
        ));
  }
}
