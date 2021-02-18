import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/product/productList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context);
    return Expanded(child: checkBody(menu.menu));
  }

  Widget checkBody(String menu) {
    switch (menu) {
      case 'ออร์เดอร์':
        return Container();
        break;
      case 'อาหาร':
        return ProductList();
        break;
      case 'พรีออร์เดอร์':
        return Container();
        break;
      case 'โปรโมชั่น':
        return Container();
        break;
      case 'ตั้งค่าร้าน':
        return Container();
        break;
      default:
        return Container();
        break;
    }
  }
}