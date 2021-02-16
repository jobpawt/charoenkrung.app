import 'package:flutter/material.dart';
import 'package:charoenkrung_app/config/config.dart';

Widget createButton({String text, Color color, Function press}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: Config.kMargin),
    child: SizedBox(
      height: 50,
      child: RaisedButton(
        elevation: 0,
        color: color,
        onPressed: press,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
  );
}

Widget createFlatButton({String text, Color color, Function press}) {
  return FlatButton(
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 18),
      ));
}

Widget createOutlineButton({Function press, Color color, String text}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: Config.kMargin, vertical: Config.kPadding),
    child: SizedBox(
      height: 50,
      child: OutlineButton(
        onPressed: press,
        child: Text(text, style: TextStyle(color: color, fontSize: 18)),
      ),
    ),
  );
}
