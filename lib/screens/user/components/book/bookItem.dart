import 'package:charoenkrung_app/data/bookData.dart';
import 'package:charoenkrung_app/providers/bookProvider.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BookItem extends StatelessWidget {
  final BookData book;
  final WebSocketChannel channel;
  final BookProvider provider;
  final formatter = NumberFormat("#,###");

  BookItem({this.book, this.channel, this.provider});

  @override
  Widget build(BuildContext context) {
    return createItemPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              book.preOrder_name,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ประเภทการจัดส่ง : ${book.send_type}'),
              book.send_type == 'myself'
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Text('มารับวันที่ ${book.recive_date}'),
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}
