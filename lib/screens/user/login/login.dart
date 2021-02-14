import 'package:charoenkrung_app/config/config.dart';
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
      appBar: createAppBar(context: context, title: 'login'),
      body: ListView(
        children: [
          createEditText(
              controller: _email, type: EditTextType.email, text: 'email'),
          createEditText(
              controller: _password,
              type: EditTextType.password,
              text: 'password'),
          createButton(
              text: 'เข้าสู่ระบบ', color: Config.primaryColor, press: null),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("หากคุณยังไม่มีบัญชี"),
                FlatButton(
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => null)),
                    child: Text(
                      "สร้างบัญชี",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
