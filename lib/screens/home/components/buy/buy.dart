import 'dart:convert';
import 'dart:io';
import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/buyData.dart';
import 'package:charoenkrung_app/data/paymentData.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/data/promotionData.dart';
import 'package:charoenkrung_app/data/sendType.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/user/login/login.dart';
import 'package:charoenkrung_app/services/buyService.dart';
import 'package:charoenkrung_app/services/imageService.dart';
import 'package:charoenkrung_app/services/paymentService.dart';
import 'package:charoenkrung_app/services/sendTypeService.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:charoenkrung_app/utils/imageBox.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class Buy extends StatefulWidget {
  final ProductData product;
  final PromotionData promotion;

  Buy({this.product, this.promotion});

  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  int amount = 1;
  Map<String, bool> sendType = {'delivery': true, 'myself': false};
  Map<String, bool> paymentType = {'money': false, 'online': true};
  TimeOfDay time = TimeOfDay.now();
  ImagePicker picker = new ImagePicker();
  bool _serviceEnable;
  Location location = new Location();
  PermissionStatus _permisstionGranted;
  LocationData _locationData;
  File imageFile;
  String url = "";
  final _phone = TextEditingController();
  final _address = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLocation();
  }

  _checkLocation() async {
    _serviceEnable = await location.serviceEnabled();
    if (!_serviceEnable) {
      _serviceEnable = await location.requestService();
      if (!_serviceEnable) {
        return;
      }
    }

    _permisstionGranted = await location.hasPermission();
    if (_permisstionGranted == PermissionStatus.denied) {
      _permisstionGranted = await location.requestPermission();
      if (_permisstionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Config.lightColor,
      appBar: createAppBar(
          title: widget.product.name,
          color: Config.primaryColor,
          context: context),
      body: createPanel(
          child: ListView(
        children: [
          createImageBoxFromUrl(url: widget.product.url),
          Container(
            margin: EdgeInsets.all(Config.kMargin),
            child: Text(
              widget.product.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          widget.promotion != null
              ? createItemPanel(
                  child: Text(
                  'โปรโมชั่น ${widget.promotion.name}',
                  style: TextStyle(color: Colors.pink),
                ))
              : Container(),
          Container(
            margin: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                widget.promotion == null
                    ? '${widget.product.price} บาท'
                    : '${widget.promotion.price} บาท',
                style: TextStyle(fontSize: 20, color: Colors.pink),
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectNumber(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('รวมราคา ${widget.product.price * amount} บาท'),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(Config.kMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ประเภทการจัดส่ง'),
                Row(
                    children: sendType.entries
                        .map((e) => radioButton(e.key, e.value))
                        .toList())
              ],
            ),
          ),
          sendType['myself']
              ? Container(
                  margin: EdgeInsets.all(Config.kMargin),
                  child: createOutlineButton(
                      text: 'เลือกเวลา ${time.hour}:${time.minute}',
                      color: Config.darkColor,
                      press: () async {
                        final TimeOfDay picked = await showTimePicker(
                            context: context, initialTime: time);
                        if (picked != null) {
                          setState(() {
                            time = picked;
                          });
                        }
                      }),
                )
              : Container(
                  margin: EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    'จะใช้ตำแหน่ง gps ของคุณ',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
          Container(
            margin: EdgeInsets.all(Config.kMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('การชำระเงิน'),
                Row(
                    children: paymentType.entries
                        .map((e) => radioButton(e.key, e.value))
                        .toList())
              ],
            ),
          ),
          paymentType['online']
              ? Container(
                  margin: EdgeInsets.all(Config.kMargin),
                  child: createOutlineButton(
                      text: 'อัปโหลดหลักฐานการโอนเงิน',
                      color: Config.darkColor,
                      press: () async {
                        pickImage(picker).then((value) {
                          setState(() {
                            imageFile = value;
                            url = 'files/' + imageFile.path.split('/').last;
                          });
                        });
                      }),
                )
              : Container(),
          createEditText(
              controller: _phone,
              type: EditTextType.phone,
              text: 'เบอร์โทรศัพท์'),
          sendType['delivery']
              ? createEditText(
                  controller: _address,
                  type: EditTextType.text,
                  text: 'รายละเอียดที่อยู่')
              : Container(),
          createButton(
              text: 'ยืนยัน',
              color: Config.primaryColor,
              press: () {
                user.user != null
                    ? _buy(context: context, user: user.user)
                    : Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
              }),
          SizedBox(
            height: Config.kMargin,
          )
        ],
      )),
    );
  }

  _buy({BuildContext context, UserData user}) async {
    var typeOfSend = sendType['delivery'] ? 'delivery' : 'myself';
    var typeOfPayment = paymentType['online'] ? 'online' : 'money';
    var paymentURL = typeOfPayment == 'online' ? url : null;
    var position = typeOfSend == 'delivery'
        ? jsonEncode(
            {"lat": _locationData.latitude, "lon": _locationData.longitude})
        : null;
    var date = DateTime.now().toLocal().toString().split(' ')[0];
    var dateTime = '$date ${time.hour}:${time.minute}:00';
    var payment = new PaymentData(type: typeOfPayment, url: paymentURL);
    var send = new SendTypeData(
      type: typeOfSend,
      address: _address.text.trim(),
      position: position,
      recive_date: typeOfSend == 'myself' ? dateTime : null,
      phone: _phone.text.trim(),
    );

    if (imageFile != null) {
      await ImageService.upload(imageFile.path).then((value) {
        if (!value) {
          DialogBox.oneButton(
            context: context,
            title: 'เกิดข้อผิดพลาด',
            message: 'ไม่สามารถอัปโหลดรูปภาพ',
            press: () => DialogBox.close(context),
          );
        }
      });
    }

    DialogBox.loading(context: context, message: 'กำลังดำเนินการ');
    var paymentResponse =
        await PaymentService.create(data: payment, token: user.token);
    var sendResponse =
        await SendTypeService.create(data: send, token: user.token);
    if (paymentResponse.type != 'error' && sendResponse.type != 'error') {
      var buyData = new BuyData(
        payment_id: paymentResponse.data['id'],
        send_type_id: sendResponse.data['id'],
        amount: amount,
        sum: (widget.product.price * amount),
        pid: widget.product.pid,
        pro_id: widget.promotion != null ? widget.promotion.pro_id : null,
        uid: user.uid,
      );
      print('debug [buyData] => ${buyData.toJson()}');
      await BuyService.create(data: buyData, token: user.token).then((value) {
        DialogBox.close(context);
        if (value == null) {
          DialogBox.oneButton(
              context: context,
              title: 'สำเร็จ',
              message: 'คำสั่งซื้อสำเร็จ',
              press: () {
                DialogBox.close(context);
                Navigator.pop(context);
              });
        } else {
          DialogBox.oneButton(
              context: context,
              title: 'เกิดข้อผิดพลาด',
              message: value.message,
              press: () => DialogBox.close(context));
        }
      });
    } else {
      DialogBox.close(context);
      DialogBox.oneButton(
          context: context,
          title: 'เกิดข้อผิดพลาด',
          message: 'เกิดข้อผิดพลาดเกี่ยวกับ payment และ การจัดส่ง',
          press: () => DialogBox.close(context));
    }
  }

  Widget radioButton(String name, bool status) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () {
          switch (name) {
            case 'delivery':
              setState(() {
                sendType['delivery'] = true;
                sendType['myself'] = false;
              });
              break;
            case 'myself':
              setState(() {
                sendType['myself'] = true;
                sendType['delivery'] = false;
              });
              break;
            case 'money':
              setState(() {
                paymentType['money'] = true;
                paymentType['online'] = false;
              });
              break;
            case 'online':
              setState(() {
                paymentType['online'] = true;
                paymentType['money'] = false;
              });
              break;
          }
        },
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Config.darkColor)),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: status ? Config.accentColor : Colors.transparent),
                ),
              ),
            ),
            Container(
              child: Text(
                translateToThai(name),
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget selectNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            icon: Icon(
              Icons.remove_circle_outline_rounded,
              color: Config.primaryColor,
            ),
            onPressed: () {
              setState(() {
                if (amount > 1) {
                  --amount;
                }
              });
            }),
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: SizedBox(
              width: 20,
              child:
                  Align(alignment: Alignment.center, child: Text('$amount'))),
        ),
        IconButton(
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: Config.primaryColor,
            ),
            onPressed: () {
              setState(() {
                ++amount;
              });
            }),
      ],
    );
  }

  String translateToThai(String name) {
    switch (name) {
      case 'delivery':
        return 'เดลิเวอร์รี่';
        break;
      case 'myself':
        return 'รับด้วยตนเอง';
        break;
      case 'online':
        return 'ออนไลน์';
        break;
      case 'money':
        return 'เงินสด';
        break;
      default:
        return '';
        break;
    }
  }
}
