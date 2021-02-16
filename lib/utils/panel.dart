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