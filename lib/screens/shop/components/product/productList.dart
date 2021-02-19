import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/product/productItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  final String sid;

  ProductList({this.sid});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    var myProductList = productProvider.products
        .where((element) => element.sid == widget.sid)
        .toList();
    return ListView.builder(
      itemCount: myProductList.length,
      itemBuilder: (context, index) => ProductItem(
        product: myProductList[index],
      ),
    );
  }
}
