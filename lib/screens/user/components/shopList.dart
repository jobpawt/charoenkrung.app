import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/screens/shop/Shop.dart';
import 'package:charoenkrung_app/services/shopService.dart';
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
    if (shop.shops.length == 0) {
      getAllShop(shop);
    }

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: shop.shops.length,
        itemBuilder: (context, index) => ShopItem(
              shop: shop.shops[index],
            ));
  }

  getAllShop(ShopProvider shop) async {
    await ShopService.getAll().then((res) {
      shop.addAll(res.data);
    });
  }
}

class ShopItem extends StatelessWidget {
  final ShopData shop;

  ShopItem({this.shop});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(Config.kPadding),
      decoration: BoxDecoration(
          color: Config.lightColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: -1,
                offset: Offset(2, 2))
          ]),
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
                  onPressed: () => null),
              IconButton(
                  icon: SvgPicture.asset(
                    'assets/enter.svg',
                    color: Config.primaryColor,
                    height: 30,
                  ),
                  onPressed: () => enterToShop(context, shop))
            ],
          )
        ],
      ),
    );
  }

  enterToShop(BuildContext context, ShopData shop) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Shop(shop: shop)));
  }
}
