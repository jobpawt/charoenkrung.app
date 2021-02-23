import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/screens/home/components/product/productList.dart';
import 'package:charoenkrung_app/services/productService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    _getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context);
    return Expanded(child: checkBody(menu.menu));
  }

  Widget checkBody(
    String menu,
  ) {
    switch (menu) {
      case 'อาหาร':
        return ProductList();
        break;
      case 'พรีออร์เดอร์':
        return Container(
          child: Text('พรีออร์เดอร์'),
        );
        break;
      case 'โปรโมชั่น':
        return Container(
          child: Text('โปรโมชั่น'),
        );
        break;
      case 'ข่าวสาร':
        return Container(
          child: Text('ข่าวสาร'),
        );
        break;
      default:
        return Container(
          child: Text('ไม่มีรายการ'),
        );
        break;
    }
  }

  _getAllProduct() async {
    await ProductService.getAll().then((res) async {
      if (res.type != 'error') {
        var productList = res.data as List<ProductData>;
        Provider.of<ProductProvider>(context, listen: false)
            .addAll(productList);
      }
    });
  }
}
