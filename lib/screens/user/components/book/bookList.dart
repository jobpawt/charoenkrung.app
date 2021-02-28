import 'dart:convert';
import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/bookData.dart';
import 'package:charoenkrung_app/data/realtimeData.dart';
import 'package:charoenkrung_app/providers/bookProvider.dart';
import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/user/components/book/bookItem.dart';
import 'package:charoenkrung_app/services/sendTypeService.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BookList extends StatefulWidget {
  final WebSocketChannel channel = IOWebSocketChannel.connect(Config.REALTIME);

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
      return book.uid == user.uid &&
          book.status != 'reject' &&
          book.status != 'success';
    }).toList();

    return bookList.length > 0
        ? ListView.builder(
            itemCount: bookList.length,
            itemBuilder: (context, index) => BookItem(
              book: bookList[index],
              channel: channel,
              provider: Provider.of<BookProvider>(context, listen: false),
            ),
          )
        : Container();
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
