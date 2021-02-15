import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _rePass = TextEditingController();
  final _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: createAppBar(context: context, title: 'สร้างบัญชี'),
        body: ListView(
          children: [
            createEditText(
                controller: _email, type: EditTextType.email, text: 'อีเมล์'),
            createEditText(
                controller: _password,
                type: EditTextType.password,
                text: 'รหัสผ่าน'),
            createEditText(
                controller: _rePass,
                type: EditTextType.password,
                text: 'ยืนยันรหัสผ่าน'),
            createEditText(
                controller: _phone, type: EditTextType.phone, text: 'เบอร์มือถือ'),
            createButton(text: 'สร้าง', color: Config.primaryColor, press: null)
          ],
        ));
  }
}
