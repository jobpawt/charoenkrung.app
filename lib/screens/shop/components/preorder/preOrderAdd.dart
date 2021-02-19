import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/preOrderData.dart';
import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/services/imageService.dart';
import 'package:charoenkrung_app/services/preOrderService.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:charoenkrung_app/utils/imageBox.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class PreOrderAdd extends StatefulWidget {
  final String sid;
  final PreOrderData preOrder;
  final PreOrderProvider provider;

  PreOrderAdd({this.sid, this.preOrder, this.provider});

  @override
  _PreOrderAddState createState() => _PreOrderAddState();
}

class _PreOrderAddState extends State<PreOrderAdd> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _stock = TextEditingController();
  final picker = ImagePicker();
  DateTime start = DateTime.now();

  //end date is more than start 1 day
  DateTime end = DateTime.now().add(Duration(days: 1));
  File imageFile;
  String url = "";

  @override
  void initState() {
    if (widget.preOrder != null) {
      //init pre orders data for edit
      setState(() {
        _name.text = widget.preOrder.name;
        _description.text = widget.preOrder.description;
        _price.text = widget.preOrder.price.toString();
        _stock.text = widget.preOrder.stock.toString();
        start = DateTime.parse(widget.preOrder.start);
        end = DateTime.parse(widget.preOrder.end);
        url = widget.preOrder.url;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Config.accentColor,
      appBar: createAppBar(
          context: context,
          title: 'เพิ่มรายการพรีออร์เดอร์',
          color: Config.lightColor),
      body: createPanel(
          child: ListView(
        children: [
          showImage(),
          createOutlineButton(
              text: url.isEmpty ? 'เลือกรูป' : 'เปลี่ยนรูป',
              press: () {
                pickImage(picker).then((value) {
                  setState(() {
                    imageFile = value;
                    url = 'files/${value.path.split('/').last}';
                  });
                });
              }),
          createEditText(
              text: 'ชื่อ', type: EditTextType.text, controller: _name),
          createEditText(
              text: 'คำอธิบาย',
              type: EditTextType.text,
              controller: _description),
          createEditText(
              text: 'ราคา', type: EditTextType.number, controller: _price),
          createEditText(
              text: 'จำนวนสต๊อค',
              type: EditTextType.number,
              controller: _stock),
          buildDatePicker(),
          buildButton(
            context: context,
            token: user.user.token,
            provider: widget.provider,
          ),
          SizedBox(
            height: Config.kMargin,
          )
        ],
      )),
    );
  }

  Widget buildDatePicker() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Config.kMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: OutlineButton(
              child: Text(
                'วันเริ่มต้น ${start.toLocal().toString().split(' ')[0]}',
                style: TextStyle(fontSize: 12),
              ),
              onPressed: () async {
                DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: start,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025));
                if (picked != null && picked != start) {
                  setState(() {
                    start = picked;
                  });
                }
              },
            ),
          ),
          Flexible(
            child: OutlineButton(
              child: Text(
                'วันสิ้นสุด ${end.toLocal().toString().split(' ')[0]}',
                style: TextStyle(fontSize: 12),
              ),
              onPressed: () async {
                DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: end,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025));
                if (picked != null && picked != start) {
                  setState(() {
                    end = picked;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _create(
      {BuildContext context, String token, PreOrderProvider provider}) async {
    var name = _name.text.trim();
    var description = _description.text.trim();
    var price = int.parse(_price.text.trim());
    var stock = int.parse(_stock.text.trim());
    DialogBox.loading(context: context, message: 'กำลังสร้างรายการ');
    await ImageService.upload(imageFile.path).then((image) async {
      if (image) {
        //upload success
        var preOrder = PreOrderData();
        preOrder.name = name;
        preOrder.description = description;
        preOrder.price = price;
        preOrder.stock = stock;
        preOrder.start = start.toLocal().toString().split(' ')[0];
        preOrder.end = end.toLocal().toString().split(' ')[0];
        preOrder.sid = widget.sid;
        preOrder.url = url;
        await PreOrderService.create(preOrder, token).then((value) {
          DialogBox.close(context);
          if (value == null) {
            //create finished
            provider.add(preOrder);
            DialogBox.oneButton(
                context: context,
                title: 'สำเร็จ',
                message: 'เพิ่มรายการสำเร็จ',
                press: () {
                  DialogBox.close(context);
                  Navigator.pop(context);
                });
          } else {
            //create failed
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
        //upload failed
        DialogBox.close(context);
        DialogBox.oneButton(
            context: context,
            title: 'เกิดข้อผิดพลาด',
            message: 'ไม่สามารถอัปโหลดรูปภาพได้',
            press: () => DialogBox.close(context));
      }
    });
  }

  _edit({BuildContext context, String token, PreOrderProvider provider}) async {
    var newPreOrders = new PreOrderData();
    newPreOrders.name = _name.text.trim();
    newPreOrders.description = _description.text.trim();
    newPreOrders.price = int.parse(_price.text.trim());
    newPreOrders.stock = int.parse(_stock.text.trim());
    newPreOrders.pre_id = widget.preOrder.pre_id;
    newPreOrders.sid = widget.sid;
    newPreOrders.start = start.toLocal().toString().split(' ')[0];
    newPreOrders.end = end.toLocal().toString().split(' ')[0];
    newPreOrders.url = url;

    DialogBox.loading(context: context, message: 'กำลังแก้ไข');
    if (imageFile != null) {
      await ImageService.upload(imageFile.path).then((value) {
        if (value) {
          setState(() {
            url = 'file/${imageFile.path.split('/').last}';
            newPreOrders.url = url;
          });
        } else {
          DialogBox.close(context);
          DialogBox.oneButton(
              context: context,
              title: 'เกิดข้อผิดพลาด',
              message: 'ไม่สามารถอัปโหลดรูปภาพได้',
              press: () => DialogBox.close(context));
        }
      });
    }

    await PreOrderService.edit(newPreOrders, token).then((value) {
      DialogBox.close(context);
      if (value == null) {
        //edit success
        provider.edit(newPreOrders);
        DialogBox.oneButton(
            context: context,
            title: 'สำเร็จ',
            message: 'แก้ไขรายการสำเร็จ',
            press: () {
              DialogBox.close(context);
              Navigator.pop(context);
            });
      } else {
        //edit failed
        DialogBox.oneButton(
            context: context,
            title: 'เกิดข้อผิดพลาด',
            message: value.message,
            press: () {
              DialogBox.close(context);
            });
      }
    });
  }

  Widget buildButton(
      {BuildContext context, String token, PreOrderProvider provider}) {
    if (widget.preOrder == null) {
      //create
      return createButton(
          text: 'สร้าง',
          color: Config.primaryColor,
          press: () =>
              _create(context: context, token: token, provider: provider));
    } else {
      //edit
      return createButton(
          text: 'แก้ไข',
          color: Config.primaryColor,
          press: () =>
              _edit(context: context, provider: provider, token: token));
    }
  }

  Widget showImage() {
    if (imageFile != null) {
      return createImageBox(imageFile: imageFile);
    } else if (widget.preOrder != null) {
      return createImageBoxFromUrl(url: url);
    } else {
      return Container();
    }
  }
}
