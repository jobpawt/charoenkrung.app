import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/product/productAdd.dart';
import 'package:charoenkrung_app/services/productService.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final ProductData product;

  ProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    var user = Provider.of<UserProvider>(context);
    return createItemPanel(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 80,
          child: Image.network(
            '${Config.IMAGE}/${product.url}',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${product.name}',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ราคา ${product.price} บาท',
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: SvgPicture.asset(
                  'assets/delete.svg',
                  color: Config.primaryColor,
                  height: 25,
                ),
                onPressed: () => _delete(
                    context: context,
                    product: product,
                    token: user.user.token,
                    provider: provider)),
            IconButton(
                icon: SvgPicture.asset(
                  'assets/edit.svg',
                  color: Config.primaryColor,
                  height: 30,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductAdd(
                                product: product,
                                sid: product.sid,
                                provider: provider,
                              )));
                })
          ],
        )
      ],
    ));
  }

  _delete(
      {ProductProvider provider,
      ProductData product,
      String token,
      BuildContext context}) async {
    DialogBox.loading(context: context, message: 'กำลังดำเนินการ');
    await ProductService.delete(product, token).then((value) {
      DialogBox.close(context);
      if (value == null) {
        provider.remove(product);
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
