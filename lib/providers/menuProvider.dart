import 'package:flutter/material.dart';
class MenuProvider extends ChangeNotifier {
  int selected = 0;
  List<String> menus;

  MenuProvider({this.selected, this.menus});

  void choose({int index}) {
    this.selected = index;
    notifyListeners();
  }

  String get menu {
    return menus[selected];
  }
}