import 'dart:convert';
import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/buyData.dart';
import 'package:charoenkrung_app/data/realtimeData.dart';
import 'package:charoenkrung_app/providers/orderProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/order/orderItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderList extends StatefulWidget {
  final String sid;
  final WebSocketChannel channel = IOWebSocketChannel.connect(Config.REALTIME);

  OrderList({this.sid});

  @override
  _OrderListState createState() => _OrderListState(channel: this.channel);
}

class _OrderListState extends State<OrderList> {
  final WebSocketChannel channel;

  _OrderListState({this.channel}) {
    channel.stream.listen((res) {
      RealtimeData data = RealtimeData.fromJson(jsonDecode(res));
      if (data.type == 'new_buy') {
        var buyData = BuyData.fromJson(data.data);
        Provider.of<OrderProvider>(context, listen: false).add(buyData);
      } else if (data.type == 'edit_buy') {
        var buyData = BuyData.fromJson(data.data);
        Provider.of<OrderProvider>(context, listen: false).edit(buyData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<OrderProvider>(context).orders;
    var products = Provider.of<ProductProvider>(context).products;

    var myOrders = orders != null && orders.length > 0
        ? orders.where((buy) {
            return buy.sid == widget.sid;
          }).toList()
        : List<BuyData>();

    return ListView.builder(
      itemCount: myOrders.length,
      itemBuilder: (context, index) => OrderItem(
        orders: myOrders[index],
        provider: Provider.of<OrderProvider>(context, listen: false),
        channel: channel,
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
