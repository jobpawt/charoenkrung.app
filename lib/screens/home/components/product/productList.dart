import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/screens/home/components/product/productItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    var shopList = Provider.of<ShopProvider>(context).shops;
    var productList = shopList != null
        ? Provider.of<ProductProvider>(context).products.where((element) {
            var index = shopList.indexWhere((shop) => shop.sid == element.sid);
            return shopList[index].status == 'ACTIVE' &&
                element.status == 'ACTIVE';
          }).toList()
        : List<ProductData>();

    return productList.length != 0
        ? ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) => ProductItem(
                  product: productList[index],
                ))
        : Container(child: Text('ไม่มีรายการ'));
  }
}
