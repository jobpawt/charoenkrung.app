import 'package:flutter/material.dart';
AppBar createAppBar({BuildContext context, String title, Color color}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
      title,
      style:
          TextStyle(fontFamily: 'Prompt', fontSize: 20),
    ),
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined, color: color),
        onPressed: () => Navigator.pop(context)),
  );
}