import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/product/productItem.dart';
import 'package:charoenkrung_app/services/productService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.products.length == 0) {
      _getAllProduct(productProvider);
    }

    return ListView.builder(
        itemCount: productProvider.products.length,
        itemBuilder: (context, index) => ProductItem(
              product: productProvider.products[index],
            ));
  }

  _getAllProduct(ProductProvider provider) async {
    await ProductService.getAll().then((products) {
      if (products.type != 'error') {
        setState(() {
          provider.addAll(products.data);
        });
      }
    });
  }
}
