import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/user/components/shop/shopList.dart';
import 'package:charoenkrung_app/services/shopService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    _getAllShop();
  }

  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context);
    return Expanded(child: checkBody(menu.menu,));
  }

  Widget checkBody(String menu,) {
    //menus: ['ออร์เดอร์', 'จอง', 'ประวัติ', 'ร้านของฉัน']),
    switch (menu) {
      case 'ออร์เดอร์':
        return Container();
        break;
      case 'จอง':
        return Container();
        break;
      case 'ประวัติ':
        return Container();
        break;
      case 'ร้านของฉัน':
        return ShopList();
        break;
      default:
        return Container();
        break;
    }
  }

  _getAllShop() async {
    await ShopService.getAll().then((res) async {
      if (res.type != 'error') {
        var shopList = res.data as List<ShopData>;
        List<ShopData> myShop =
            shopList.where((element) => element.status != 'DELETED').toList();
        Provider.of<ShopProvider>(context, listen: false).addAll(myShop);
      }
    });
  }
}
