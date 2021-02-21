import 'dart:convert';

import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/dayData.dart';
import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/services/shopService.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/openDaySelect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingShop extends StatefulWidget {
  final ShopData shop;

  SettingShop({this.shop});

  @override
  _SettingShopState createState() => _SettingShopState();
}

class _SettingShopState extends State<SettingShop> {
  bool isOpen = false;
  DayData openDays;

  @override
  void initState() {
    super.initState();
    openDays = DayData.fromJson(widget.shop.open);
    if (widget.shop.status != 'NOT ALLOW') {
      isOpen = widget.shop.status == 'ACTIVE';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('เปิด/ปิด ร้าน'),
              )),
              Switch(
                activeColor: Config.primaryColor,
                value: isOpen,
                onChanged: (value) {
                  if (widget.shop.status != 'NOT ALLOW') {
                    setState(() {
                      isOpen = value;
                    });
                  } else {
                    DialogBox.oneButton(
                        context: context,
                        title: 'ข้อผิดพลาด',
                        message: 'ร้านของคุณยังไม่ได้รับการอนุญาติ',
                        press: () => DialogBox.close(context));
                  }
                },
              )
            ],
          ),
          isOpen
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: Config.kMargin),
                  child: OpenDaySelect(days: openDays),
                )
              : Container(),
          createButton(
              text: 'ใช้งาน',
              color: Config.primaryColor,
              press: () async {
                var newShop = widget.shop;
                newShop.open = jsonEncode(openDays.toJson());
                newShop.status = isOpen ? 'ACTIVE' : 'DISABLE';
                var token = Provider.of<UserProvider>(context, listen: false)
                    .user
                    .token;
                DialogBox.loading(context: context, message: 'กำลังบันทึก');
                await ShopService.edit(shop: newShop, token: token)
                    .then((value) {
                  DialogBox.close(context);
                  if (value == null) {
                    DialogBox.oneButton(
                        title: 'สำเร็จ',
                        message: 'บันทึกสำเร็จ',
                        context: context,
                        press: () {
                          DialogBox.close(context);
                        });
                  } else {
                    DialogBox.oneButton(
                        context: context,
                        title: 'เกิดข้อผิดพลาด',
                        message: value.message,
                        press: () => DialogBox.close(context));
                  }
                });
              })
        ],
      ),
    );
  }

  bool _checkOpenDay({DayData openDays}) {
    var today = DateTime.now().toLocal().weekday;
    var days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursdays',
      'friday',
      'saturday',
      'sunday'
    ];
    switch (days[today - 1]) {
      case 'monday':
        return openDays.monday;
        break;
      case 'tuesday':
        return openDays.tuesday;
        break;
      case 'wednesday':
        return openDays.wednesday;
        break;
      case 'thursday':
        return openDays.thursday;
        break;
      case 'friday':
        return openDays.friday;
        break;
      case 'saturday':
        return openDays.saturday;
        break;
      case 'sunday':
        return openDays.sunday;
        break;
      default:
        return false;
        break;
    }
  }
}
