import 'package:flutter/material.dart';

class YesOrNoDialog {
  static Future<bool> create(BuildContext context, content,
      {title = "Tem certeza?",
      trueText = "Sim",
      falseText = "Não",
      Function trueCallback,
      Function falseCallback}) {
    Function trueCallbackWithPop = () {
      if (trueCallback != null) {
        trueCallback();
      }
      Navigator.of(context).pop(true);
    };

    Function falseCallbackWithPop = () {
      if (falseCallback != null) {
        falseCallback();
      }
      Navigator.of(context).pop(false);
    };

    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text(trueText),
                onPressed: trueCallbackWithPop,
              ),
              FlatButton(
                child: Text(falseText),
                onPressed: falseCallbackWithPop,
              )
            ],
          );
        });
  }
}
