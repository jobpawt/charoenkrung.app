import 'dart:convert';

import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/bookData.dart';
import 'package:charoenkrung_app/data/realtimeData.dart';
import 'package:charoenkrung_app/providers/bookProvider.dart';
import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/book/bookItem.dart';
import 'package:charoenkrung_app/services/paymentService.dart';
import 'package:charoenkrung_app/services/sendTypeService.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BookList extends StatefulWidget {
  final String sid;
  final WebSocketChannel channel = IOWebSocketChannel.connect(Config.REALTIME);

  BookList({this.sid});

  @override
  _BookListState createState() => _BookListState(channel: channel);
}

class _BookListState extends State<BookList> {
  final WebSocketChannel channel;

  _BookListState({this.channel}) {
    channel.stream.listen((res) {
      RealtimeData data = RealtimeData.fromJson(jsonDecode(res));
      if (data.type == 'new_book') {
        var buyData = BookData.fromJson(data.data);
        Provider.of<BookProvider>(context, listen: false).add(buyData);
      } else if (data.type == 'edit_book') {
        var buyData = BookData.fromJson(data.data);
        Provider.of<BookProvider>(context, listen: false).edit(buyData);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var preOrders = Provider.of<PreOrderProvider>(context).preOrders;
    var user = Provider.of<UserProvider>(context).user;
    var bookList = Provider.of<BookProvider>(context).books.where((book) {
      var index =
          preOrders.indexWhere((preOrder) => preOrder.pre_id == book.pre_id);
      return preOrders[index].sid == widget.sid;
    }).toList();
    return bookList.length > 0
        ? ListView.builder(
            itemCount: bookList.length,
            itemBuilder: (context, index) => BookItem(
              book: bookList[index],
              preOrder: preOrders.firstWhere(
                  (element) => element.pre_id == bookList[index].pre_id),
              sendType: _getSendType(bookList[index].send_type_id, user.token),
              payment: _getPayment(bookList[index].payment_id, user.token),
              channel: channel,
              provider: Provider.of<BookProvider>(context, listen: false),
            ),
          )
        : Container();
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
