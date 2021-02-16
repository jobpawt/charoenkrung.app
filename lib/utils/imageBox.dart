import 'package:flutter/material.dart';
import 'package:charoenkrung_app/config/config.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

Widget createImageBox(File imageFile) {
 return Container(
    margin: EdgeInsets.all(Config.kMargin),
    height: 200,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Config.kRadius)),
        image: DecorationImage(
            image: new FileImage(imageFile),
            fit: BoxFit.fill
        )
    ),
  );
}

Future<File> pickImage(ImagePicker picker) async {
  var file = await picker.getImage(source: ImageSource.gallery);
  if (file != null) {
    return File(file.path);
 }else{
    return null;
  }
}
