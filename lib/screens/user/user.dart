import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/user/components/option.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/menuBar.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/screens/user/components/body.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List<ShopData> shopList = new List();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MenuProvider(
              selected: 0,
              menus: ['ออร์เดอร์', 'จอง', 'ประวัติ', 'ร้านของฉัน']),
        ),
        ChangeNotifierProvider(create: (_) => ShopProvider(shops: shopList)),
      ],
      child: Scaffold(
        backgroundColor: Config.accentColor,
        appBar: createAppBar(
            context: context, title: 'ผู้ใช้งาน', color: Colors.white),
        body: Column(
          children: [profile(context, user), body()],
        ),
      ),
    );
  }

  Widget body() {
    return Expanded(
        child: createPanel(
            child: Column(children: [MenuBar(), Options(), Body()])));
  }

  Widget profile(BuildContext context, UserProvider user) {
    var data = user.user;
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 5),
      padding: EdgeInsets.symmetric(horizontal: Config.kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    'assets/email.svg',
                    color: Config.lightColor,
                    width: 24,
                  ),
                  onPressed: null),
              Text(
                '${data.email}',
                style: TextStyle(color: Config.darkColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    'assets/phone.svg',
                    color: Config.lightColor,
                    width: 24,
                  ),
                  onPressed: null),
              Text(
                '${data.phone}',
                style: TextStyle(color: Config.darkColor),
              ),
            ],
          ),
          createFlatButton(
              text: 'ออกจากระบบ',
              color: Config.primaryColor,
              press: () => _logout(context, user))
        ],
      ),
    );
  }

  _logout(BuildContext context, UserProvider user) {
    user.logout();
    Navigator.pop(context);
  }
}
