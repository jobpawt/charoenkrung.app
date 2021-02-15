import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/home/components/body.dart';
import 'package:charoenkrung_app/screens/user/login/login.dart';
import 'package:charoenkrung_app/utils/menuBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => MenuProvider(
                menus: ['อาหาร', 'พรีออร์เดอร์', 'โปรโมชั่น', 'ข่าวสาร'], selected: 0))
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:
            buildAppBar(context: context, user: user, title: 'ตลาดเจริญกรุง ๑๐๓'),
        body: buildBody(context: context),
      ),
    );
  }

  Widget buildBody({BuildContext context}) {
    return Column(
      children: [MenuBar(), Body()],
    );
  }

  AppBar buildAppBar({BuildContext context, UserData user, String title}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black),
      ),
      actions: [
        user == null
            ? Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        color: Config.primaryColor,
                      ),
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Login())))
                ],
              )
            : Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.sms, color: Config.primaryColor),
                      onPressed: null),
                  IconButton(
                      icon: Icon(Icons.menu, color: Config.primaryColor),
                      onPressed: null)
                ],
              )
      ],
    );
  }
}