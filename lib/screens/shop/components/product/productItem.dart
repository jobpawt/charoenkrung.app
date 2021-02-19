import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/product/addProduct.dart';
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
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'สถานะ ${product.status}',
                style: TextStyle(color: Colors.pink, fontSize: 12),
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
                onPressed: () => _delete(provider, product)),
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
                          builder: (context) => AddProduct(
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

  _delete(ProductProvider provider, ProductData product) {
    provider.remove(product);
  }
}
