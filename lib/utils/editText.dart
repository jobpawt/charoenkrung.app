import 'package:flutter/material.dart';

enum EditTextType {
  email,
  text,
  number,
  phone,
  password
}

Widget createEditText(
    {TextEditingController controller, EditTextType type, String text}) {
  switch (type) {
    case EditTextType.email:
      return Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: text, border: OutlineInputBorder()),
        ),
      );
      break;
    case EditTextType.text:
      return Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              labelText: text, border: OutlineInputBorder()),
        ),
      );
      break;
    case EditTextType.number:
      return Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              labelText: text, border: OutlineInputBorder()),
        ),
      );
      break;
    case EditTextType.phone:
      return Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              labelText: text, border: OutlineInputBorder()),
        ),
      );
      break;
    case EditTextType.password:
      return Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          obscureText: true,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              labelText: text, border: OutlineInputBorder()),
        ),
      );
      break;
    default:
      return Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              labelText: text, border: OutlineInputBorder()),
        ),
      );
      break;
  }
}
