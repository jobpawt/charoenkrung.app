import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/promotionProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/preorder/preOrderAdd.dart';
import 'package:charoenkrung_app/screens/shop/components/product/productAdd.dart';
import 'package:charoenkrung_app/screens/shop/components/promotion/promotionAdd.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Options extends StatelessWidget {
  final String sid;

  Options({this.sid});

  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context);
    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    var preOrderProvider =
        Provider.of<PreOrderProvider>(context, listen: false);
    var promotionProvider =
        Provider.of<PromotionProvider>(context, listen: false);

    return buildOptions(
        context: context,
        menu: menu.menu,
        productProvider: productProvider,
        preOrderProvider: preOrderProvider,
        promotionProvider: promotionProvider);
  }

  Widget buildOptions(
      {BuildContext context,
      String menu,
      ProductProvider productProvider,
      PreOrderProvider preOrderProvider,
      PromotionProvider promotionProvider}) {
    switch (menu) {
      case 'ออร์เดอร์':
        return Container();
        break;
      case 'อาหาร':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createFlatButtonWithIcon(
                text: 'เพิ่มรายการอาหาร',
                icon: Icons.add,
                color: Config.primaryColor,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductAdd(
                                sid: sid,
                                product: null,
                                provider: productProvider,
                              )));
                })
          ],
        );
        break;
      case 'พรีออร์เดอร์':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createFlatButtonWithIcon(
                text: 'เพิ่มรายการพรีออร์เดอร์',
                icon: Icons.add,
                color: Config.primaryColor,
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreOrderAdd(
                        sid: sid,
                        preOrder: null,
                        provider: preOrderProvider,
                      ),
                    )))
          ],
        );
        break;
      case 'โปรโมชั่น':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createFlatButtonWithIcon(
                text: 'สร้างโปรโมชั่น',
                icon: Icons.add,
                color: Config.primaryColor,
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PromotionAdd(
                            productList: productProvider.products,
                            promotion: null,
                            provider: promotionProvider))))
          ],
        );
        break;
      case 'ตั้งค่าร้าน':
        return Container();
        break;
      default:
        return Container();
        break;
    }
  }
}
