import 'package:flutter/material.dart';

enum EditTextType { email, text, number, phone, password }

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
              filled: true,
              fillColor: Colors.white,
              labelText: text,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
        ),
      );
      break;
    case EditTextType.text:
      return Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: text,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
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
              filled: true,
              fillColor: Colors.white,
              labelText: text,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
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
              filled: true,
              fillColor: Colors.white,
              labelText: text,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
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
              filled: true,
              fillColor: Colors.white,
              labelText: text,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
        ),
      );
      break;
    default:
      return Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: text,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
        ),
      );
      break;
  }
}
