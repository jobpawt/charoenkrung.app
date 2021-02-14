import 'package:flutter/material.dart';

Widget createButton({String text, Color color, Function press}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: SizedBox(
      height: 50,
      child: RaisedButton(
        elevation: 0,
        color: color,
        onPressed: () => press(),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}
