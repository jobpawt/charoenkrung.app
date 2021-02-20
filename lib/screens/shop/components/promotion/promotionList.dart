import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/promotionProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/promotion/promotionItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionList extends StatefulWidget {
  final String sid;

  PromotionList({this.sid});

  @override
  _PromotionListState createState() => _PromotionListState();
}

class _PromotionListState extends State<PromotionList> {
  @override
  Widget build(BuildContext context) {
    var promotionProvider = Provider.of<PromotionProvider>(context);
    var productList = Provider.of<ProductProvider>(context)
        .products
        .where((element) => element.sid == widget.sid)
        .toList();

    //search promotion which it's myself
    var myPromotionList = promotionProvider.promotions.where((promotion) {
      var haveData = false;
      productList.forEach((element) {
        if (element.pid == promotion.pid && promotion.status != 'DELETED') {
          haveData = true;
        }
      });
      return haveData;
    }).toList();

    return ListView.builder(
        itemCount: myPromotionList.length,
        itemBuilder: (context, index) => PromotionItem(
              promotion: myPromotionList[index],
            ));
  }
}
