import 'package:charoenkrung_app/config/config.dart';
import 'package:flutter/material.dart';
Widget createPanel({Widget child}) {
  return Container(
          margin: EdgeInsets.only(top: Config.kMargin),
          padding: EdgeInsets.only(top: Config.kPadding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Config.kRadius),
                  topRight: Radius.circular(Config.kRadius)),
              color: Colors.white), 
              child: child,
      );
}

Widget createItemPanel({Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    padding: EdgeInsets.all(Config.kPadding),
    decoration: BoxDecoration(
      color: Config.lightColor,
      shape: BoxShape.rectangle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 5,
          spreadRadius: -1,
          offset: Offset(2,2)
        )
      ]
    ),
    child: child,
  );
}