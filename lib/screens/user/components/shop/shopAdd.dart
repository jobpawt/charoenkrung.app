import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/dayData.dart';
import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/services/imageService.dart';
import 'package:charoenkrung_app/services/shopService.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:charoenkrung_app/utils/imageBox.dart';
import 'package:charoenkrung_app/utils/openDaySelect.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:charoenkrung_app/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class ShopAdd extends StatefulWidget {
  @override
  _ShopAddState createState() => _ShopAddState();
}

class _ShopAddState extends State<ShopAdd> {
  final picker = ImagePicker();
  final days = new DayData();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  final _bank = TextEditingController();
  File _imageFile;
  String url = "";

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: createAppBar(
          context: context, title: 'สร้างร้านค้า', color: Colors.white),
      body: createPanel(
          child: ListView(
        children: [
          _imageFile != null
              ? createImageBox(imageFile: _imageFile)
              : Container(),
          createOutlineButton(
            text: 'เลือกรูป',
            color: Config.primaryColor,
            press: () => pickImage(picker).then((file) {
              if (file != null) {
                setState(() {
                  _imageFile = file;
                  url = 'files/${file.path.split('/').last}';
                });
              }
            }),
          ),
          createEditText(
              controller: _name, text: 'ชื่อร้าน', type: EditTextType.text),
          createEditText(
              controller: _address,
              text: 'ที่อยู่ร้าน',
              type: EditTextType.text),
          createEditText(
              controller: _phone,
              text: 'เบอร์โทรศัพท์ร้าน',
              type: EditTextType.phone),
          createEditText(
              controller: _bank, text: 'พร้อมเพย์', type: EditTextType.number),
          OpenDaySelect(
            days: days,
          ),
          createButton(
              text: 'สร้าง',
              color: Config.primaryColor,
              press: () => _createShop(context, user.user)),
          SizedBox(height: Config.kMargin)
        ],
      )),
    );
  }

  _createShop(BuildContext context, UserData user) async {
    var name = _name.text.trim();
    var address = _address.text.trim();
    var phone = _phone.text.trim();
    var bank = _bank.text.trim();
    if (validate(
        name: name, address: address, phone: phone, bank: bank, url: url)) {
      DialogBox.loading(context: context, message: 'กำลังสร้างร้าน');
      await ImageService.upload(_imageFile.path).then((res) async {
        if (res) {
          //upload image success
          var shop = new ShopData(
              name: name,
              address: address,
              phone: phone,
              bank: bank,
              url: url,
              open: days.days.toString(),
              uid: user.uid);
          await ShopService.create(shop: shop, user: user).then((res) {
            DialogBox.close(context);
            if (res != null && res.type == 'error') {
              DialogBox.oneButton(
                  context: context,
                  message: res.message,
                  title: 'เกิดข้อผิดพลาด',
                  press: () {
                    DialogBox.close(context);
                  });
            } else {
              DialogBox.oneButton(
                  context: context,
                  message: 'สร้างร้านแล้ว กรุณารอเจ้าหน้าที่ตรวจสอบ',
                  title: 'สำเร็จ',
                  press: () {
                    DialogBox.close(context);
                    Navigator.pop(context);
                  });
            }
          });
        }
      });
    }
  }

  bool validate(
      {String name, String address, String phone, String bank, String url}) {
    return Validate(context: context, title: 'ชื่อร้าน')
            .isNotEmpty(name)
            .check() &&
        Validate(context: context, title: 'ที่อยู่ร้าน')
            .isNotEmpty(address)
            .check() &&
        Validate(context: context, title: 'เบอร์โทรศัพท์')
            .isNotEmpty(phone)
            .check() &&
        Validate(context: context, title: 'พร้อมเพย์')
            .isNotEmpty(bank)
            .check() &&
        Validate(context: context, title: 'รูปภาพ').isNotEmpty(url).check();
  }
}
