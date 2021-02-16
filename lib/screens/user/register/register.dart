import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/services/userService.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:charoenkrung_app/utils/validate.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _rePass = TextEditingController();
  final _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.accentColor,
        appBar: createAppBar(
            context: context, title: 'สร้างบัญชี', color: Colors.white),
        body: createPanel(
          child: ListView(
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
                  controller: _phone,
                  type: EditTextType.phone,
                  text: 'เบอร์มือถือ'),
              SizedBox(
                height: Config.kSpace,
              ),
              createButton(
                  text: 'สร้าง',
                  color: Config.primaryColor,
                  press: () => register(context))
            ],
          ),
        ));
  }

  register(BuildContext context) async {
    String email = _email.text.trim();
    String password = _password.text.trim();
    String rePassword = _rePass.text.trim();
    String phone = _phone.text.trim();

    if (validate(
        context: context,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone)) {
      UserData user = new UserData(
          email: email, password: password, phone: phone, role: "user");
      DialogBox.loading(context: context, message: 'กำลังสร้างบัญชี');
      await UserService.register(user).then((res) {
        DialogBox.close(context);
        if (res.type == "error") {
          DialogBox.oneButton(
              context: context,
              message: res.message,
              title: 'เกิดข้อผิดพลาด',
              press: () => DialogBox.close(context));
        } else {
          DialogBox.oneButton(
              context: context,
              message: res.message,
              title: 'สำเร็จ',
              press: () {
                DialogBox.close(context);
                Navigator.pop(context);
              });
        }
      });
    }
  }

  bool validate(
      {BuildContext context,
      String email,
      String password,
      String rePassword,
      String phone}) {
    return Validate(context: context, title: 'email')
            .isNotEmpty(email)
            .check() &&
        Validate(context: context, title: 'password')
            .isNotEmpty(password)
            .isEqual(password, rePassword)
            .check() &&
        Validate(context: context, title: 'phone').isNotEmpty(phone).check();
  }
}
