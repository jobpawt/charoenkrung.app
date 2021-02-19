import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
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

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: shop.shops.length,
        itemBuilder: (context, index) => ShopItem(
              shop: shop.shops[index],
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
