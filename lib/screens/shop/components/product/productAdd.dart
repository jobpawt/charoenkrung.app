import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/services/imageService.dart';
import 'package:charoenkrung_app/services/productService.dart';
import 'package:charoenkrung_app/utils/appBar.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/editText.dart';
import 'package:charoenkrung_app/utils/imageBox.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:charoenkrung_app/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class AddProduct extends StatefulWidget {
  final String sid;
  final ProductData product;
  final ProductProvider provider;

  AddProduct({this.sid, this.product, this.provider});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _stock = TextEditingController();

  File imageFile;
  ImagePicker picker = new ImagePicker();
  int typeSelectedIndex = 0;
  var type = ['อาหาร', 'เครื่องดื่ม', 'ขนม', 'ของใช้'];

  //Edit by pid
  String pid = "";
  String url = "";

  @override
  void initState() {
    if (widget.product != null) {
      setState(() {
        _name.text = widget.product.name;
        _description.text = widget.product.description;
        _price.text = widget.product.price.toString();
        _stock.text = widget.product.stock.toString();
        url = widget.product.url;
        pid = widget.product.pid;
        typeSelectedIndex = widget.product.type_id - 1;
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
            color: Config.lightColor,
            title: 'เพิ่มรายการอาหาร',
            context: context),
        body: createPanel(
            child: ListView(
          children: [
            showImage(),
            createTypeSelect(),
            createEditText(
                text: 'ชื่อ', type: EditTextType.email, controller: _name),
            createEditText(
                text: 'คำอธิบาย',
                type: EditTextType.text,
                controller: _description),
            createEditText(
                text: 'ราคา', type: EditTextType.number, controller: _price),
            createEditText(
                text: 'จำนวนสต๊อก',
                type: EditTextType.number,
                controller: _stock),
            buildButton(context, user.user.token, widget.provider),
            SizedBox(
              height: Config.kMargin,
            )
          ],
        )));
  }

  Widget createTypeSelect() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Config.kMargin),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Config.kPadding),
                child: Text('ประเภท'),
              ),
              DropdownButton<String>(
                value: type[typeSelectedIndex],
                icon: Icon(
                  Icons.arrow_downward_outlined,
                  color: Config.primaryColor,
                ),
                iconSize: 16,
                elevation: 16,
                style: TextStyle(color: Config.darkColor),
                onChanged: (String value) {
                  setState(() {
                    var index = type.indexWhere((element) => element == value);
                    typeSelectedIndex = index;
                  });
                },
                items: type.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
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
        ],
      ),
    );
  }

  Widget buildButton(BuildContext context, String token, ProductProvider provider) {
    if (widget.product == null) {
      return createButton(
          text: 'สร้าง',
          color: Config.primaryColor,
          press: () => _create(context, token, provider));
    } else {
      return createButton(
          text: 'แก้ไข',
          color: Config.primaryColor,
          press: () => _edit(context, token, provider));
    }
  }

  Widget showImage() {
    if (imageFile != null && widget.product == null) {
      return createImageBox(imageFile: imageFile);
    } else if (widget.product != null) {
      return createImageBoxFromUrl(url: url);
    } else {
      return Container();
    }
  }

  //edit product
  _edit(BuildContext context, String token, ProductProvider provider) async {
    var newProduct = new ProductData();
    newProduct.name = _name.text.trim();
    newProduct.description = _description.text.trim();
    newProduct.price = int.parse(_price.text.trim());
    newProduct.stock = int.parse(_stock.text.trim());
    newProduct.type_id = typeSelectedIndex + 1;
    newProduct.sid = widget.sid.trim();
    newProduct.pid = widget.product.pid;
    newProduct.status = widget.product.status;
    newProduct.url = url;

    DialogBox.loading(context: context, message: 'กำลังแก้ไข');
    if (imageFile != null) {
      await ImageService.upload(imageFile.path).then((value) {
        if (value) {
          setState(() {
            url = '/files/' + imageFile.path.split('/').last;
            newProduct.url = url;
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

    if (validate(
        context: context,
        name: newProduct.name,
        description: newProduct.description,
        price: newProduct.price.toString(),
        stock: newProduct.stock.toString(),
        url: newProduct.url)) {
      await ProductService.edit(newProduct, token).then((value) {
        DialogBox.close(context);
        if (value == null) {
          //edit file success
          provider.edit(newProduct);
          DialogBox.oneButton(
              context: context,
              title: 'สำเร็จ',
              message: 'แก้ไขรายการสำเร็จ',
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
    }
  }

  //add product
  _create(BuildContext context, String token, ProductProvider provider) async {
    var name = _name.text.trim();
    var description = _description.text.trim();
    var price = _price.text.trim();
    var stock = _stock.text.trim();
    if (validate(
        name: name,
        description: description,
        price: price,
        stock: stock,
        url: url)) {
      DialogBox.loading(context: context, message: 'กำลังเพิ่มรายการ');
      ImageService.upload(imageFile.path).then((image) async {
        var product = ProductData(
            name: name,
            sid: widget.sid,
            description: description,
            price: int.parse(price),
            stock: int.parse(stock),
            type_id: typeSelectedIndex + 1,
            url: url);
        if (image) {
          await ProductService.create(product: product, token: token)
              .then((value) {
            DialogBox.close(context);
            if (value == null) {
              //create finished
              provider.add(product);
              DialogBox.oneButton(
                  context: context,
                  title: 'สำเร็จ',
                  message: 'เพิ่มรายการสำเร็จ',
                  press: () {
                    DialogBox.close(context);
                    Navigator.pop(context);
                  });
            } else {
              //create failed show error to dialog box
              print(product.toJson());
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
              message: 'ไม่สามารถอัปโหลดไฟล์รูปภาพได้',
              press: () => DialogBox.close(context));
        }
      });
    }
  }

  bool validate(
      {BuildContext context,
      String name,
      String description,
      String price,
      String stock,
      String url}) {
    return Validate(context: context, title: 'ชื่อ').isNotEmpty(name).check() &&
        Validate(context: context, title: 'คำอธิบาย')
            .isNotEmpty(description)
            .check() &&
        Validate(context: context, title: 'ราคา').isNotEmpty(price).check() &&
        Validate(context: context, title: 'จำนวนสต๊อค')
            .isNotEmpty(stock)
            .check();
  }
}
