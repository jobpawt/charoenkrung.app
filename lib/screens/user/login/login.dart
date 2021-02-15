import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/screens/user/register/register.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: createAppBar(context: context, title: 'เข้าสู่ระบบ'),
      body: ListView(
        children: [
          createEditText(
              controller: _email, type: EditTextType.email, text: 'อีเมล์'),
          createEditText(
              controller: _password,
              type: EditTextType.password,
              text: 'รหัสผ่าน'),
          createButton(
              text: 'เข้าสู่ระบบ', color: Config.primaryColor, press: null),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("หากคุณยังไม่มีบัญชี"),
                createFlatButton(
                    text: 'สมัครสมาชิก',
                    color: Config.darkColor,
                    press: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register())))
              ],
            ),
          )
        ],
      ),
    );
  }
}
