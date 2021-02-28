import 'dart:io';
import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/bookData.dart';
import 'package:charoenkrung_app/data/paymentData.dart';
import 'package:charoenkrung_app/data/preOrderData.dart';
import 'package:charoenkrung_app/data/sendType.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/services/bookService.dart';
import 'package:charoenkrung_app/services/imageService.dart';
import 'package:charoenkrung_app/services/paymentService.dart';
import 'package:charoenkrung_app/services/preOrderService.dart';
import 'package:charoenkrung_app/services/sendTypeService.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:charoenkrung_app/utils/imageBox.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Book extends StatefulWidget {
  final PreOrderData preOrder;

  Book({this.preOrder});

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  int amount = 1;
  Map<String, bool> paymentType = {'money': false, 'online': true};
  ImagePicker picker = new ImagePicker();
  File imageFile;
  String url = "";
  DateTime pickupDate = new DateTime.now();
  final _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    setState(() {
      _phone.text = user.user.phone;
    });
    return Scaffold(
      backgroundColor: Config.lightColor,
      appBar: createAppBar(
        title: widget.preOrder.name,
        color: Config.primaryColor,
        context: context,
      ),
      body: createPanel(
        child: ListView(
          children: [
            createImageBoxFromUrl(url: widget.preOrder.url),
            Container(
              margin: EdgeInsets.all(Config.kMargin),
              child: Text(
                widget.preOrder.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  '${widget.preOrder.price} บาท',
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
                      child:
                          Text('รวมราคา ${widget.preOrder.price * amount} บาท'),
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
                        text: imageFile == null
                            ? 'อัปโหลดหลักฐานการโอนเงิน'
                            : 'อัปโหลดแล้ว',
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
            Container(
              margin: EdgeInsets.all(Config.kMargin),
              child: createOutlineButton(
                text:
                    'กำหนดวันมารับ  ${pickupDate.toLocal().toString().split(' ')[0]}',
                color: Config.darkColor,
                press: () async {
                  DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: pickupDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025));
                  if (picked != null && picked != pickupDate) {
                    setState(() {
                      pickupDate = picked;
                    });
                  }
                },
              ),
            ),
            createEditText(
              controller: _phone,
              type: EditTextType.phone,
              text: 'เบอร์โทรศัพท์',
            ),
            Container(
              margin: EdgeInsets.all( 20),
              child: createButton(
                  text: 'ยืนยัน',
                  color: Config.primaryColor,
                  press: () => _book(context: context, user: user.user)),
            ),
            SizedBox(
              height: Config.kMargin,
            )
          ],
        ),
      ),
    );
  }

  _book({BuildContext context, UserData user}) async {
    var typeOfPayment = paymentType['online'] ? 'online' : 'money';
    var paymentURL = typeOfPayment == 'online' ? url : null;
    var payment = new PaymentData(type: typeOfPayment, url: paymentURL);
    var send = new SendTypeData(
      type: 'myself',
      address: null,
      position: null,
      phone: _phone.text.trim(),
      recive_date: pickupDate.toLocal().toString(),
    );
    //try to upload payment picture
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
      //create book
      var bookData = new BookData(
        pre_id: widget.preOrder.pre_id,
        uid: user.uid,
        send_type_id: sendResponse.data['id'],
        payment_id: paymentResponse.data['id'],
        sum: (widget.preOrder.price * amount),
        amount: amount,
      );
      await BookService.create(data: bookData, token: user.token).then((value) async {
        DialogBox.close(context);
        //edit stock
        widget.preOrder.stock = widget.preOrder.stock - bookData.amount;
        await PreOrderService.edit(widget.preOrder, user.token);

        if (value == null) {
          DialogBox.oneButton(
              context: context,
              title: 'สำเร็จ',
              message: 'ยืนยันการจองเรียบร้อย',
              press: () {
                DialogBox.close(context);
                Navigator.pop(context);
              });
        } else {
          DialogBox.oneButton(
              context: context,
              title: 'เกิดข้อผิดพลาด',
              message: value.message,
              press: () {
                DialogBox.close(context);
              });
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
                name == 'online' ? 'ออนไลน์' : 'เงินสด',
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
}
