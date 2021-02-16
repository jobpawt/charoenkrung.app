import 'dart:io';
import 'package:flutter/material.dart';
import 'package:charoenkrung_app/config/config.dart';

Widget createImageBox(File imageFile) {
  if (imageFile != null) {
    return Container(
        margin: EdgeInsets.all(Config.kMargin),
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Config.kRadius)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(imageFile.path),
            )));
  } else {
    return Container();
  }
}
