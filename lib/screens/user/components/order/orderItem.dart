import 'package:charoenkrung_app/data/buyData.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderItem extends StatelessWidget {
  final BuyData order;
  final WebSocketChannel channel;

  OrderItem({this.order, this.channel});

  @override
  Widget build(BuildContext context) {
    return createItemPanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.date.toString().split('T')[0],
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                order.product_name,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            order.promotion_name != null ?
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '+ โปรโมชั่น :${order.promotion_name}',
                style: TextStyle(fontSize: 14),
              ),
            ) : Container(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text('จำนวน ${order.amount} รวม ${order.sum} บาท'),
            ),
            Text(
              'สถานะ ${order.status}',
              style: TextStyle(fontSize: 14, color: Colors.teal),
            )
          ],
        ));
  }
}
