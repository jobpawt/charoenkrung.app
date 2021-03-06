import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/promotionProvider.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/screens/home/components/product/productList.dart';
import 'package:charoenkrung_app/screens/home/components/promotion/promotionItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionList extends StatefulWidget {
  @override
  _PromotionListState createState() => _PromotionListState();
}

class _PromotionListState extends State<PromotionList> {
  @override
  Widget build(BuildContext context) {
    var productList = Provider.of<ProductProvider>(context).products;
    var shopList = Provider.of<ShopProvider>(context).shops;
    var promotionList =
        Provider.of<PromotionProvider>(context).promotions.where((element) {
      DateTime start = DateTime.parse(element.start);
      DateTime end = DateTime.parse(element.end);
      int left = end.difference(start).inDays -
          DateTime.now().difference(start).inDays;
      var index =
          productList.indexWhere((product) => product.pid == element.pid);
      var shop =
          shopList.firstWhere((shop) => productList[index].sid == shop.sid);
      return left > 0 &&
          shop.status == 'ACTIVE' &&
          productList[index].status == 'ACTIVE';
    }).toList();

    return promotionList.length != 0
        ? ListView.builder(
            itemCount: promotionList.length,
            itemBuilder: (context, index) => PromotionItem(
              product: productList.firstWhere(
                  (element) => element.pid == promotionList[index].pid),
              promotion: promotionList[index],
            ),
          )
        : Container(child: Text('ไม่มีรายการ'));
  }
}
