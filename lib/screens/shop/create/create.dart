import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/dayData.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:charoenkrung_app/utils/imageBox.dart';
import 'package:charoenkrung_app/utils/openDaySelect.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:charoenkrung_app/utils/pickImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class CreateShop extends StatefulWidget {
  @override
  _CreateShopState createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  final picker = ImagePicker();
  final days = new DayData();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  final _bank = TextEditingController();
  File _imageFile;
  String url = "";

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: createAppBar(
          context: context, title: 'สร้างร้านค้า', color: Colors.white),
      body: createPanel(
          child: ListView(
        children: [
          createImageBox(_imageFile),
          createEditText(
              controller: _name, text: 'ชื่อร้าน', type: EditTextType.text),
          createEditText(
              controller: _address,
              text: 'ที่อยู่ร้าน',
              type: EditTextType.text),
          createEditText(
              controller: _phone,
              text: 'เบอร์โทรศัพท์ร้าน',
              type: EditTextType.phone),
          createEditText(
              controller: _bank, text: 'พร้อมเพย์', type: EditTextType.number),
          createOutlineButton(
            text: 'เลือกรูป',
            color: Config.primaryColor,
            press: () {
              pickImage(picker: picker).then((value) {
                setState(() {
                  _imageFile = File(value);
                  url = "/files/${value.split('/').last}";
                });
              });
            },
          ),
          OpenDaySelect(
            days: days,
          ),
          createButton(text: 'สร้าง', color: Config.primaryColor, press: () {}),
          SizedBox(height: Config.kMargin)
        ],
      )),
    );
  }
}
