import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/data/promotionData.dart';
import 'package:charoenkrung_app/providers/promotionProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/services/promotionService.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:charoenkrung_app/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionAdd extends StatefulWidget {
  final PromotionData promotion;
  final PromotionProvider provider;
  final List<ProductData> productList;

  PromotionAdd({this.promotion, this.provider, this.productList});

  @override
  _PromotionAddState createState() => _PromotionAddState();
}

class _PromotionAddState extends State<PromotionAdd> {
  final _name = TextEditingController();
  final _price = TextEditingController();
  var dropdownValue = '';
  int selectedIndex = 0;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(Duration(days: 1));

  @override
  void initState() {
    if (widget.promotion != null) {
      //edit
      _name.text = widget.promotion.name;
      _price.text = widget.promotion.price.toString();
      start = DateTime.parse(widget.promotion.start);
      end = DateTime.parse(widget.promotion.end);
    }
    dropdownValue = widget.productList[selectedIndex].name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Config.accentColor,
      appBar: createAppBar(
          context: context,
          title: widget.promotion == null ? 'สร้างโปรโมชั่น' : 'แก้ไขโปรโมชั่น',
          color: Config.lightColor),
      body: createPanel(
          child: ListView(
        children: [
          createEditText(
              text: 'ชื่อโปรโมชั่น',
              type: EditTextType.text,
              controller: _name),
          buildPickProduct(),
          showProductDetail(),
          createEditText(
              text: 'ราคาโปรโมชั่น',
              type: EditTextType.number,
              controller: _price),
          buildDatePicker(),
          buildButton(
              context: context,
              token: user.user.token,
              provider: widget.provider)
        ],
      )),
    );
  }

  _create(
      {BuildContext context, String token, PromotionProvider provider}) async {
    var promotion = new PromotionData();
    promotion.name = _name.text.trim();
    promotion.price = int.parse(_price.text.trim());
    promotion.pid = widget.productList[selectedIndex].pid;
    promotion.start = start.toLocal().toString().split(' ')[0];
    promotion.end = start.toLocal().toString().split(' ')[0];
    if (_validate(
        context: context,
        name: promotion.name,
        price: promotion.price.toString())) {
      DialogBox.loading(context: context, message: 'กำลังสร้างโปรโมชั่น');

      await PromotionService.create(promotion, token).then((value) {
        DialogBox.close(context);
        if (value == null) {
          DialogBox.oneButton(
              context: context,
              title: 'สำเร็จ',
              message: 'สร้างโปรโมชั่นสำเร็จ',
              press: () {
                provider.add(promotion);
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
    }
  }

  bool _validate({BuildContext context, String name, String price}) {
    return Validate(context: context, title: 'ชื่อโปรโมชั่น')
            .isNotEmpty(name)
            .check() &&
        Validate(context: context, title: 'ราคา').isNotEmpty(price).check();
  }

  Widget buildButton(
      {BuildContext context, String token, PromotionProvider provider}) {
    if (widget.promotion == null) {
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
              _edit(context: context, token: token, provider: provider));
    }
  }

  _edit(
      {BuildContext context, PromotionProvider provider, String token}) async {
    var newPromotion = new PromotionData();
    newPromotion.name = _name.text.trim();
    newPromotion.price = int.parse(_price.text.trim());
    newPromotion.start = start.toLocal().toString().split(' ')[0];
    newPromotion.end = end.toLocal().toString().split(' ')[0];
    newPromotion.pro_id = widget.promotion.pro_id;
    newPromotion.pid = widget.productList[selectedIndex].pid;
    DialogBox.loading(context: context, message: 'กำลังแก้ไข');
    await PromotionService.edit(newPromotion, token).then((value) {
      DialogBox.close(context);
      if (value == null) {
        provider.edit(newPromotion);
        DialogBox.oneButton(
            context: context,
            title: 'สำเร็จ',
            message: 'แก้ไขโปรโมชั่นสำเร็จ',
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
  }

  Widget showProductDetail() {
    var product = widget.productList[selectedIndex];
    return createItemPanel(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 80,
          child: Image.network(
            '${Config.IMAGE}/${product.url}',
            fit: BoxFit.cover,
          ),
        ),
        Text(
          '${product.price} บาท',
        ),
        Text('จำนวน ${product.stock}')
      ],
    ));
  }

  Widget buildPickProduct() {
    return widget.productList.length > 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text('เลือกสินค้า'),
              Container(
                height: 50,
                child: DropdownButton(
                    value: dropdownValue,
                    items: widget.productList
                        .map<DropdownMenuItem<String>>((product) {
                      return DropdownMenuItem<String>(
                          value: product.name,
                          child: Text(
                            product.name,
                            overflow: TextOverflow.visible,
                          ));
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        selectedIndex = widget.productList
                            .indexWhere((element) => element.name == newValue);
                      });
                    }),
              ),
            ],
          )
        : Container(
            margin: EdgeInsets.all(20),
            child: Text('ไม่มีรายการสินค้าให้สร้างโปรโมชั่น'),
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
}
