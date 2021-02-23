import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/screens/shop/Shop.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
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
                  '${shop.name}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
              /*
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'สถานะ ${shop.status}',
                  style: TextStyle(color: Colors.pink, fontSize: 12),
                ),
              )
               */
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
