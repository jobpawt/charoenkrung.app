import 'package:charoenkrung_app/data/preOrderData.dart';
import 'package:flutter/material.dart';

class PreOrderProvider extends ChangeNotifier {
  List<PreOrderData> preOrders = new List();

  void add(PreOrderData preOrder) {
    preOrders.add(preOrder);
    notifyListeners();
  }

  void remove(PreOrderData preOrder) {
    var index = preOrders.indexWhere((element) => element.pre_id == preOrder.pre_id);
    preOrders.removeAt(index);
    notifyListeners();
  }

  void addAll(List<PreOrderData> preOrderList) {
    preOrders.addAll(preOrderList);
    notifyListeners();
  }

  void edit(PreOrderData preOrder) {
    var index = preOrders.indexWhere((element) => element.pre_id == preOrder.pre_id);
    preOrders[index] = preOrder;
    notifyListeners();
  }

}
