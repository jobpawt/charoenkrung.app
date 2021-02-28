import 'dart:convert';

import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/buyData.dart';
import 'package:charoenkrung_app/data/paymentData.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/data/promotionData.dart';
import 'package:charoenkrung_app/data/realtimeData.dart';
import 'package:charoenkrung_app/data/sendType.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/orderProvider.dart';
import 'package:charoenkrung_app/providers/promotionProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/services/buyService.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderItem extends StatelessWidget {
  final BuyData orders;
  final OrderProvider provider;
  final WebSocketChannel channel;

  OrderItem({this.orders, this.provider, this.channel});

  @override
  Widget build(BuildContext context) {
    PromotionData promotion;
    var user = Provider.of<UserProvider>(context);
    if (orders.pro_id != null) {
      promotion = Provider.of<PromotionProvider>(context)
          .promotions
          .firstWhere((element) => element.pro_id == orders.pro_id);
    }
    return createItemPanel(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          orders.product_name,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'จำนวน ${orders.amount} รวม ${orders.sum} บาท',
            style: TextStyle(fontSize: 16),
          ),
        ),
        orders.promotion_name != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'โปรโมชั่น',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: Config.kMargin),
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(orders.promotion_name),
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ประเภทการจัดส่ง : ${orders.send_type ?? '-'}'),
            orders.send_type == 'myself'
                ? createFlatButton(text: 'มารับตอน ${orders.recive_date}')
                : Container()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('การชำระเงินแบบ : ${orders.payment_type}'),
            orders.payment_type == 'online'
                ? createFlatButton(
                    text: 'ตรวจสอบการโอนเงิน',
                    color: Config.darkColor,
                    press: () => DialogBox.imageDialog(
                        context: context, url: orders.payment_url),
                  )
                : Container()
          ],
        ),
        SizedBox(
          height: Config.kMargin,
        ),
        buildButton(orders.status, user.user)
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
              orders.status = 'reject';
              //send data to another
              await BuyService.edit(data: orders, token: user.token)
                  .then((value) {
                if (value == null) {
                  channel.sink.add(jsonEncode(
                      RealtimeData(type: 'edit_buy', data: orders.toJson())));
                  provider.edit(orders);
                }
              });
            },
          ),
          createButton(
            text: 'ยืนยัน',
            color: Config.primaryColor,
            press: () async {
              orders.status = 'confirm';
              //send data to another
              await BuyService.edit(data: orders, token: user.token)
                  .then((value) {
                if (value == null) {
                  channel.sink.add(jsonEncode(
                      RealtimeData(type: 'edit_buy', data: orders.toJson())));
                  provider.edit(orders);
                }
              });
            },
          ),
        ]);
        break;
      case 'confirm':
        return Center(
          child: Text(
            'ยืนยันออร์เดอร์แล้ว',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
        break;
      case 'reject':
      default:
        return Center(
          child: Text(
            'ออร์เดอร์ถูกยกเลิกแล้ว',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
    }
  }
}
