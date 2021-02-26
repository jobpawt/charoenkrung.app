import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/utils/imageBox.dart';
import 'package:flutter/material.dart';

class DialogBox {
  static oneButton(
      {BuildContext context, String title, String message, Function press}) {
    var alert = AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: Config.darkColor),
      ),
      content: Text(message),
      actions: [
        FlatButton(
            onPressed: press,
            child: Text(
              'ตกลง',
              style: TextStyle(color: Config.primaryColor),
            ))
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }

  static loading({BuildContext context, String message}) {
    var alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(message),
          )
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) => alert,
        barrierDismissible: true);
  }

  static close(BuildContext context) {
    Navigator.pop(context);
  }

  static imageDialog({BuildContext context, String url}) {
    var alert = AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.network('${Config.IMAGE}/$url'),
      ),
      actions: [
        FlatButton(
            onPressed: () => DialogBox.close(context),
            child: Text(
              'ตกลง',
              style: TextStyle(color: Config.primaryColor),
            ))
      ],
    );

    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }
}
