import 'package:charoenkrung_app/data/productData.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductData> products = new List();

  void add(ProductData product) {
    products.add(product);
    notifyListeners();
  }

  void remove(int index) {
    products.removeAt(index);
    notifyListeners();
  }

  void addAll(List<ProductData> productList) {
    products.addAll(productList);
    notifyListeners();
  }

  void edit(ProductData product) {
    var index = products.indexWhere((element) => element.pid == product.pid);
    products[index] = product;
    notifyListeners();
  }

}