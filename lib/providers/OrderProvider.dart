import 'package:charoenkrung_app/data/buyData.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  List<BuyData> orders = new List();

  void add(BuyData order) {
    orders.add(order);
    notifyListeners();
  }

  void remove(BuyData order) {
    var index = orders.indexWhere((element) => element.buy_id == order.buy_id);
    orders.removeAt(index);
    notifyListeners();
  }

  void addAll(List<BuyData> orderList) {
    orders.addAll(orderList);
    notifyListeners();
  }

  void edit(BuyData order) {
    var index = orders.indexWhere((element) => element.buy_id== order.buy_id);
    orders[index] = order;
    notifyListeners();
  }

}
