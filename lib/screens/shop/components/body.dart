import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/promotionProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/preorder/preOrderList.dart';
import 'package:charoenkrung_app/screens/shop/components/product/productList.dart';
import 'package:charoenkrung_app/screens/shop/components/promotion/promotionList.dart';
import 'package:charoenkrung_app/services/preOrderService.dart';
import 'package:charoenkrung_app/services/productService.dart';
import 'package:charoenkrung_app/services/promotionService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  final String sid;

  Body({this.sid});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    _getAllProduct();
    _getAllPreOrder();
    _getAllPromotions();
  }

  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context);
    return Expanded(child: checkBody(menu.menu));
  }

  Widget checkBody(String menu) {
    switch (menu) {
      case 'ออร์เดอร์':
        return Container();
        break;
      case 'อาหาร':
        return ProductList(sid: widget.sid);
        break;
      case 'พรีออร์เดอร์':
        return PreOrderList(sid: widget.sid);
        break;
      case 'โปรโมชั่น':
        return PromotionList(sid: widget.sid);
        break;
      case 'ตั้งค่าร้าน':
        return Container();
        break;
      default:
        return Container();
        break;
    }
  }

  _getAllProduct() async {
    await ProductService.getAll().then((products) {
      if (products.type != 'error') {
        Provider.of<ProductProvider>(context, listen: false).addAll(products
            .data
            .where((product) => product.sid == widget.sid)
            .toList());
      }
    });
  }

  _getAllPreOrder() async {
    await PreOrderService.getAll().then((preOrders) {
      if (preOrders.type != 'error') {
        Provider.of<PreOrderProvider>(context, listen: false).addAll(preOrders
            .data
            .where((preOrder) => preOrder.sid == widget.sid)
            .toList());
      }
    });
  }

  _getAllPromotions() async {
    await PromotionService.getAll().then((promotions) {
      if (promotions.type != 'error') {
        Provider.of<PromotionProvider>(context, listen: false)
            .addAll(promotions.data);
      }
    });
  }
}
