import 'package:charoenkrung_app/data/buyData.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderItem extends StatelessWidget {
  final BuyData order;
  final ProductData product;
  final WebSocketChannel channel;

  OrderItem({this.order, this.product, this.channel});

  @override
  Widget build(BuildContext context) {
    return createItemPanel(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(order.date.toString().split('T')[0]),
        Text(
          product.name,
          style: TextStyle(fontSize: 16),
        ),
        Text('สถานะ ${order.status}')
      ],
    ));
  }
}
