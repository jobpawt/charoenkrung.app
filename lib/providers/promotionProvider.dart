import 'package:charoenkrung_app/data/promotionData.dart';
import 'package:flutter/material.dart';

class PromotionProvider extends ChangeNotifier {
  List<PromotionData> promotions = List();

  void add(PromotionData promotion) {
    promotions.add(promotion);
    notifyListeners();
  }

  void addAll(List<PromotionData> promotionList) {
    promotions.addAll(promotionList);
    notifyListeners();
  }

  void remove(PromotionData promotion) {
    var index =
        promotions.indexWhere((element) => element.pro_id == promotion.pro_id);
    promotions.removeAt(index);
    notifyListeners();
  }

  void edit(PromotionData promotion) {
    var index =
        promotions.indexWhere((element) => element.pro_id == promotion.pro_id);
    promotions[index] = promotion;
    notifyListeners();
  }
}
