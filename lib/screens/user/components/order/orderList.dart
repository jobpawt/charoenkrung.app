import 'dart:convert';
import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/buyData.dart';
import 'package:charoenkrung_app/data/realtimeData.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/orderProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/screens/user/components/order/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderList extends StatefulWidget {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect('${Config.REALTIME}');
  final UserData user;

  OrderList({this.user});

  @override
  _OrderListState createState() => _OrderListState(channel: channel);
}

class _OrderListState extends State<OrderList> {
  final WebSocketChannel channel;

  _OrderListState({this.channel}) {
    channel.stream.listen((res) {
      RealtimeData data = RealtimeData.fromJson(jsonDecode(res));
      if (data.type == 'edit_buy') {
        var buyData = BuyData.fromJson(data.data);
        if (buyData.uid == widget.user.uid) {
          Provider.of<OrderProvider>(context, listen: false).edit(buyData);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductProvider>(context).products;

    List<BuyData> ordersList =
        Provider.of<OrderProvider>(context).orders.where((element) {
      return element.uid == widget.user.uid;
    }).toList();

    return ordersList.length > 0 && products.length > 0
        ? ListView.builder(
            itemCount: ordersList.length,
            itemBuilder: (context, index) => OrderItem(
                  order: ordersList[index],
                  product: products.firstWhere(
                      (element) => element.pid == ordersList[index].pid),
                  channel: channel,
                ))
        : Container();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}