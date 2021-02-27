import 'package:charoenkrung_app/data/bookData.dart';
import 'package:charoenkrung_app/data/preOrderData.dart';
import 'package:charoenkrung_app/data/sendType.dart';
import 'package:charoenkrung_app/providers/bookProvider.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BookItem extends StatelessWidget {
  final BookData book;
  final PreOrderData preOrder;
  final Future<ServerResponse> sendType;
  final WebSocketChannel channel;
  final BookProvider provider;
  final formatter = NumberFormat("#,###");

  BookItem(
      {this.book, this.preOrder, this.sendType, this.channel, this.provider});

  @override
  Widget build(BuildContext context) {
    return createItemPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              preOrder.name,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
                'จำนวน ${book.amount} รวม ${formatter.format(book.sum)} บาท'),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'สถานะ ${book.status}',
              style: TextStyle(fontSize: 14),
            ),
          ),
          FutureBuilder(
              future: sendType,
              builder: (context, snapshot) {
                var res = snapshot.data as ServerResponse;
                var send = res != null && res.type != 'error'
                    ? res.data as SendTypeData
                    : null;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ประเภทการจัดส่ง : ${send?.type ?? '-'}'),
                    send?.type == 'myself'
                        ? Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Text(
                                  'มารับวันที่ ${send?.recive_date?.split('T')[0]}'),
                              margin: EdgeInsets.symmetric(vertical: 10),
                            ),
                          )
                        : Container()
                  ],
                );
              }),
        ],
      ),
    );
  }
}
