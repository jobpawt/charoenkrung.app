import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context);
    List menus = menu.menus;
    int selected = menu.selected;

    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          height: 30,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: menus.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => menu.choose(index: index),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: selected == index
                            ? Config.darkColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      menus[index],
                      style: TextStyle(
                          fontSize: 14,
                          color:
                              selected == index ? Colors.white : Colors.black),
                    ),
                  ),
                );
              }),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
