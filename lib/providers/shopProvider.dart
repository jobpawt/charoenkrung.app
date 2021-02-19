import 'package:charoenkrung_app/data/shopData.dart';
import 'package:flutter/material.dart';

class ShopProvider extends ChangeNotifier {
  List<ShopData> shops;

  ShopProvider({this.shops}) {
    notifyListeners();
  }

  void add(ShopData shop) {
    shops.add(shop);
    notifyListeners();
  }

  void addAll(List<ShopData> shopList) {
    shops.addAll(shopList);
    notifyListeners();
  }

  void remove(ShopData shop) {
    var index = shops.indexWhere((element) => element.sid == shop.sid);
    shops.removeAt(index);
    notifyListeners();
  }

  void edit(ShopData shop) {
    var index = shops.indexWhere((element) => element.sid == shop.sid);
    shops[index] = shop;
    notifyListeners();
  }

  List<ShopData> get shopList {
    return this.shops;
  }
}
