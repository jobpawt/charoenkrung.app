import 'package:charoenkrung_app/data/preOrderData.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/data/promotionData.dart';
import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/promotionProvider.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/screens/home/components/preorder/preOrderList.dart';
import 'package:charoenkrung_app/screens/home/components/product/productList.dart';
import 'package:charoenkrung_app/screens/home/components/promotion/promotionList.dart';
import 'package:charoenkrung_app/services/preOrderService.dart';
import 'package:charoenkrung_app/services/productService.dart';
import 'package:charoenkrung_app/services/promotionService.dart';
import 'package:charoenkrung_app/services/shopService.dart';
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
    _getAllPreOrder();
    _getAllPromotion();
    _getAllProduct();
    _getAllShop();
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
        return PreOrderList();
        break;
      case 'โปรโมชั่น':
        return PromotionList();
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

  _getAllPreOrder() async {
    await PreOrderService.getAll().then((res) async {
      if (res.type != 'error') {
        var preOrderList = res.data as List<PreOrderData>;
        Provider.of<PreOrderProvider>(context, listen: false)
            .addAll(preOrderList);
      }
    });
  }

  _getAllPromotion() async {
    await PromotionService.getAll().then((res) async {
      if (res.type != 'error') {
        var promotionList = res.data as List<PromotionData>;
        Provider.of<PromotionProvider>(context, listen: false)
            .addAll(promotionList);
      }
    });
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

  _getAllShop() async {
    await ShopService.getAll().then((res) async {
      if (res.type != 'error') {
        var shopList = res.data as List<ShopData>;
        print('debug ${shopList.length}');
        List<ShopData> myShop =
            shopList.where((element) => element.status != 'DELETED').toList();
        Provider.of<ShopProvider>(context, listen: false).addAll(myShop);
      }
    });
  }
}
