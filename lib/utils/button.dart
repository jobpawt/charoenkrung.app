import 'package:flutter/material.dart';

Widget createButton({String text, Color color, Function press}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 40),
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
