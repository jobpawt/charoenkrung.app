import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/shop/Shop.dart';
import 'package:charoenkrung_app/services/shopService.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class ShopItem extends StatelessWidget {
  final ShopData shop;

  ShopItem({this.shop});

  @override
  Widget build(BuildContext context) {
    return createItemPanel(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ร้าน : ${shop.name}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'สถานะ ${shop.status}',
                  style: TextStyle(color: Colors.pink, fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    'assets/delete.svg',
                    color: Config.primaryColor,
                    height: 25,
                  ),
                  onPressed: () => _delete(context, shop)),
              IconButton(
                  icon: SvgPicture.asset(
                    'assets/enter.svg',
                    color: Config.primaryColor,
                    height: 30,
                  ),
                  onPressed: () => _goToShop(context, shop))
            ],
          )
        ],
      ),
    );
  }

  _delete(BuildContext context, ShopData shop) {
    Provider.of<ShopProvider>(context, listen: false).remove(shop);
  }

  _goToShop(BuildContext context, ShopData shop) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Shop(shop: shop)));
  }
}
