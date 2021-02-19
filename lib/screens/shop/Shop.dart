import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/body.dart';
import 'package:charoenkrung_app/screens/shop/components/option.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/menuBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Shop extends StatelessWidget {
  final ShopData shop;

  Shop({this.shop});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => MenuProvider(selected: 0, menus: [
              'ออร์เดอร์',
              'อาหาร',
              'พรีออร์เดอร์',
              'โปรโมชั่น',
              'ตั้งค่าร้าน'
            ]),
          ),
          ChangeNotifierProvider(create: (_) => ProductProvider())
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: createAppBar(
              color: Config.darkColor, context: context, title: shop.name),
          body: Column(
            children: [MenuBar(), Options(sid: shop.sid), Body()],
          ),
        ));
  }
}
