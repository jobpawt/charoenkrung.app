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

  void delete(int index) {
    shops.removeAt(index);
    notifyListeners();
  }

  void edit(ShopData shop, int index) {
    shops[index] = shop;
    notifyListeners();
  }

  List<ShopData> get shopList {
    return this.shops;
  }

}