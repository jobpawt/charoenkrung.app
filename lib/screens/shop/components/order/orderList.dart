import 'dart:convert';
import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/buyData.dart';
import 'package:charoenkrung_app/data/paymentData.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/data/realtimeData.dart';
import 'package:charoenkrung_app/providers/orderProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/order/orderItem.dart';
import 'package:charoenkrung_app/services/paymentService.dart';
import 'package:charoenkrung_app/services/sendTypeService.dart';
import 'package:charoenkrung_app/utils/response.dart';
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
      if(data.type == 'new_buy'){
        var buyData = BuyData.fromJson(data.data);
        Provider.of<OrderProvider>(context, listen: false).add(buyData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<OrderProvider>(context).orders;
    var products = Provider.of<ProductProvider>(context).products;
    var user = Provider.of<UserProvider>(context).user;

    var myOrders = orders != null && orders.length > 0
        ? orders.where((buy) {
            var index =
                products.indexWhere((product) => product.pid == buy.pid);
            return products[index].sid == widget.sid;
          }).toList()
        : List<BuyData>();

    return ListView.builder(
      itemCount: myOrders.length,
      itemBuilder: (context, index) => OrderItem(
        orders: myOrders[index],
        product: products
            .firstWhere((element) => element.pid == myOrders[index].pid),
        payment: _getPayment(myOrders[index].payment_id, user.token),
        sendType: _getSendType(myOrders[index].send_type_id, user.token),
        provider: Provider.of<OrderProvider>(context, listen: false),
        channel: channel,
      ),
    );
  }

  Future<ServerResponse> _getPayment(String id, String token) async {
    return await PaymentService.get(payment_id: id, token: token);
  }

  Future<ServerResponse> _getSendType(String id, String token) async {
    return await SendTypeService.get(id: id, token: token);
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
