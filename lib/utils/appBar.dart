import 'package:charoenkrung_app/config/config.dart';
import 'package:flutter/material.dart';
AppBar createAppBar({BuildContext context, String title}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
      title,
      style:
          Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black),
    ),
    leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Config.primaryColor),
        onPressed: () => Navigator.pop(context)),
  );
}