import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/preorder/preOrderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreOrderList extends StatefulWidget {
  final String sid;

  PreOrderList({this.sid});

  @override
  _PreOrderListState createState() => _PreOrderListState();
}

class _PreOrderListState extends State<PreOrderList> {
  @override
  Widget build(BuildContext context) {
    var preOrderProvider = Provider.of<PreOrderProvider>(context);
    var myPreOrderList = preOrderProvider.preOrders
        .where((element) =>
            element.sid == widget.sid && element.status != 'DELETED')
        .toList();
    return ListView.builder(
      itemCount: myPreOrderList.length,
      itemBuilder: (context, index) => PreOrderItem(
        sid: widget.sid,
        preOrder: myPreOrderList[index],
      ),
    );
  }
}
