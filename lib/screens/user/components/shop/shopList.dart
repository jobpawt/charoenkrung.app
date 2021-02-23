import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/user/components/shop/shopItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopList extends StatefulWidget {
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  Widget build(BuildContext context) {
    var shop = Provider.of<ShopProvider>(context);
    var user = Provider.of<UserProvider>(context);
    var myShopList =
        shop.shops.where((element) => element.uid == user.user.uid).toList();

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: myShopList.length,
        itemBuilder: (context, index) => ShopItem(
              shop: myShopList[index],
            ));
  }
}

