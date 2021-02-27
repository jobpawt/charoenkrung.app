import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/screens/home/components/preorder/preOrderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreOrderList extends StatefulWidget {
  @override
  _PreOrderListState createState() => _PreOrderListState();
}

class _PreOrderListState extends State<PreOrderList> {
  @override
  Widget build(BuildContext context) {
    var shopList = Provider.of<ShopProvider>(context).shops;
    var preOrderList =
        Provider.of<PreOrderProvider>(context).preOrders.where((element) {
      var start = DateTime.parse(element.start);
      var end = DateTime.parse(element.end);
      int left = end.difference(start).inDays -
          DateTime.now().difference(start).inDays;
      var index = shopList.indexWhere((shop) => shop.sid == element.sid);
      return left > 0 &&
          shopList[index].status == 'ACTIVE' &&
          element.status == 'ACTIVE';
    }).toList();

    return preOrderList.length != 0
        ? ListView.builder(
            itemCount: preOrderList.length,
            itemBuilder: (context, index) => PreOrderItem(
                  preOrder: preOrderList[index],
                ))
        : Container(child: Text('ไม่มีรายการ'));
  }
}
