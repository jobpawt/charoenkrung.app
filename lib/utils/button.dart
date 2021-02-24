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

Widget createFlatButtonWithIcon(
    {String text, Color color, Function press, IconData icon}) {
  return FlatButton(
      onPressed: press,
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          Text(
            text,
            style: TextStyle(color: color),
          )
        ],
      ));
}

Widget createOutlineButton({Function press, Color color, String text}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: Config.kMargin),
    child: SizedBox(
      height: 50,
      child: OutlineButton(
        onPressed: press,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text, style: TextStyle(color: color, fontSize: 14)),
        ),
      ),
    ),
  );
}
