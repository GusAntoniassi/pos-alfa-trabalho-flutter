import 'package:flutter/material.dart';
import 'package:aula02bd/constants.dart' as Constants;

class AppTextField {
  static Widget create(TextEditingController controller, String label,
      {prefix = "",
      textInputType = TextInputType.text,
      color = Constants.SECONDARY_COLOR,
      textSize = Constants.FONT_SIZE,
      left = 20.0,
      top = 10.0,
      right = 20.0,
      bottom = 10.0,
      Color labelColor}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: labelColor ?? color),
              border: OutlineInputBorder(),
              focusColor: Constants.PRIMARY_COLOR,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: Constants.PRIMARY_COLOR)),
              prefixText: prefix,
            ),
            style: TextStyle(color: color, fontSize: textSize),
            keyboardType: textInputType));
  }
}
