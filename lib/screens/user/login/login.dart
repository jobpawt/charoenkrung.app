import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/user/register/register.dart';
import 'package:charoenkrung_app/services/userService.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Config.accentColor,
        appBar: createAppBar(
            context: context, title: 'เข้าสู่ระบบ', color: Colors.white),
        body: createPanel(
          child: ListView(
            children: [
              createEditText(
                  controller: _email, type: EditTextType.email, text: 'อีเมล์'),
              createEditText(
                  controller: _password,
                  type: EditTextType.password,
                  text: 'รหัสผ่าน'),
              SizedBox(
                height: Config.kSpace,
              ),
              createButton(
                  text: 'เข้าสู่ระบบ',
                  color: Config.primaryColor,
                  press: () => login(context)),
              SizedBox(
                height: Config.kSpace,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text("หากคุณยังไม่มีบัญชี"),
                    createFlatButton(
                        text: 'สมัครสมาชิก',
                        color: Config.darkColor,
                        press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register())))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  login(BuildContext context) async {
    var email = _email.text.trim();
    var password = _password.text.trim();
    DialogBox.loading(message: 'กำลังเข้าสู่ระบบ', context: context);
    await UserService.login(UserData(email: email, password: password))
        .then((res) {
      DialogBox.close(context);
      if (res.type == "error") {
        DialogBox.oneButton(
            context: context,
            message: res.message,
            title: 'เกิดข้อผิดพลาด',
            press: () => DialogBox.close(context));
      } else if (res.data is UserData) {
        Provider.of<UserProvider>(context, listen: false).login(res.data);
        Navigator.pop(context);
      }
    });
  }
}
