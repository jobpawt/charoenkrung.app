import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/home/components/body.dart';
import 'package:charoenkrung_app/screens/user/login/login.dart';
import 'package:charoenkrung_app/utils/menuBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                menus: ['อาหาร', 'พรีออร์เดอร์', 'โปรโมชั่น', 'ข่าวสาร'],
                selected: 0))
      ],
      child: Scaffold(
        backgroundColor: Config.lightColor,
        appBar: buildAppBar(
            context: context, user: user, title: 'ตลาดเจริญกรุง ๑๐๓'),
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
      actions: [
        user == null
            ? Row(
                children: [
                  IconButton(
                      icon: SvgPicture.asset(
                        'assets/Myuser.svg',
                        color: Config.darkColor,
                      ),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login())))
                ],
              )
            : Row(
                children: [
                  IconButton(
                      icon: SvgPicture.asset('assets/Mychat.svg',
                          color: Config.darkColor),
                      onPressed: null),
                  IconButton(
                      icon: SvgPicture.asset('assets/Mymenu.svg',
                          color: Config.darkColor),
                      onPressed: null)
                ],
              )
      ],
    );
  }
}
