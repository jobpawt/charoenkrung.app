import 'dart:convert';

import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/bookData.dart';
import 'package:charoenkrung_app/data/paymentData.dart';
import 'package:charoenkrung_app/data/preOrderData.dart';
import 'package:charoenkrung_app/data/realtimeData.dart';
import 'package:charoenkrung_app/data/sendType.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/bookProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/services/bookService.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BookItem extends StatelessWidget {
  final BookData book;
  final PreOrderData preOrder;
  final Future<ServerResponse> payment;
  final Future<ServerResponse> sendType;
  final WebSocketChannel channel;
  final BookProvider provider;
  final formatter = NumberFormat("#,###");

  BookItem(
      {this.book,
      this.preOrder,
      this.payment,
      this.sendType,
      this.channel,
      this.provider});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return createItemPanel(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.date,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
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
          child: Text('สถานะ ${book.status}'),
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
                      ? Container(
                          child: Text(
                              'มารับตอน ${send?.recive_date?.split('T')[0]}'),
                          margin: EdgeInsets.symmetric(vertical: 10),
                        )
                      : Container()
                ],
              );
            }),
        FutureBuilder(
          future: payment,
          builder: (context, snapshot) {
            var res = snapshot.data as ServerResponse;
            PaymentData payment =
                res != null && res.type != 'error' ? res.data : null;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'การชำระเงินแบบ : ${payment != null ? payment.type : '-'}'),
                payment != null && payment.type == 'online'
                    ? createFlatButton(
                        text: 'ตรวจสอบการโอนเงิน',
                        color: Config.darkColor,
                        press: () => DialogBox.imageDialog(
                            context: context, url: payment.url),
                      )
                    : Container()
              ],
            );
          },
        ),
        buildButton(book.status, user.user)
      ],
    ));
  }

  Widget buildButton(String status, UserData user) {
    switch (status) {
      case 'waiting':
        return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          createButton(
            text: 'ปฏิเสธ',
            color: Colors.red,
            press: () async {
              book.status = 'reject';
              //send data to another
              await BookService.edit(data: book, token: user.token)
                  .then((value) {
                if (value == null) {
                  channel.sink.add(jsonEncode(
                      RealtimeData(type: 'edit_book', data: book.toJson())));
                  print(RealtimeData(type: 'edit_book', data: book.toJson()));
                  provider.edit(book);
                }
              });
            },
          ),
          createButton(
            text: 'ยืนยัน',
            color: Config.primaryColor,
            press: () async {
              book.status = 'confirm';
              //send data to another
              await BookService.edit(data: book, token: user.token)
                  .then((value) {
                if (value == null) {
                  channel.sink.add(jsonEncode(
                      RealtimeData(type: 'edit_book', data: book.toJson())));
                  provider.edit(book);
                }
              });
            },
          ),
        ]);
        break;
      case 'confirm':
        return Column(
          children: [
            Center(
              child: Text(
                'ยืนยันออร์เดอร์แล้ว',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(Config.kMargin),
                child: createButton(
                    text: 'ยืนยันการรับสินค้า',
                    color: Colors.pink,
                    press: () async {
                      book.status = 'success';
                      //send data to another
                      await BookService.edit(data: book, token: user.token)
                          .then((value) {
                        if (value == null) {
                          channel.sink.add(
                            jsonEncode(
                              RealtimeData(
                                  type: 'edit_book', data: book.toJson()),
                            ),
                          );
                          provider.edit(book);
                        }
                      });
                    }),
              ),
            )
          ],
        );
        break;
      case 'reject':
        return Center(
          child: Text(
            'ถูกยกเลิกแล้ว',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
        break;
      case 'success':
        return Center(
          child: Text(
            'ส่งสำเร็จแล้ว',
            style: TextStyle(color: Colors.teal, fontSize: 16),
          ),
        );
        break;
      default:
        return Center(
          child: Text('-'),
        );
    }
  }
}
