import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/home/components/body.dart';
import 'package:charoenkrung_app/utils/menuBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                MenuProvider(menus: ['all', 'food', 'pre-order', 'promotion']))
      ],
      child: Scaffold(
        appBar:
            buildAppBar(context: context, user: user, title: "Charoenkrung"),
        body: buildBody(context: context),
      ),
    );
  }

  Widget buildBody({BuildContext context}) {
    return Column(
      children: [
        MenuBar(),
        Consumer<MenuProvider>(builder: (context, menu, child) {
          return Body(
            products: null,
          );
        })
      ],
    );
  }

  AppBar buildAppBar({BuildContext context, UserProvider user, String title}) {
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
                      onPressed: null)
                ],
              )
            : Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.sms,
                        color: Config.primaryColor),
                      onPressed: null),
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Config.primaryColor
                      ),
                      onPressed: null)
                ],
              )
      ],
    );
  }
}
