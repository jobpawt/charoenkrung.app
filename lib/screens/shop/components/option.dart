import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context);
    return buildOptions(context, menu.menu);
  }

  Widget buildOptions(BuildContext context, String menu) {
    switch (menu) {
      case 'ออร์เดอร์':
        return Container();
        break;
      case 'อาหาร':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createFlatButtonWithIcon(
                text: 'เพิ่มรายการอาหาร',
                icon: Icons.add,
                color: Config.lightColor,
                press: () => null)
          ],
        );
        break;
      case 'พรีออร์เดอร์':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createFlatButtonWithIcon(
                text: 'เพิ่มรายการพรีออร์เดอร์',
                icon: Icons.add,
                color: Config.lightColor,
                press: () => null)
          ],
        );
        break;
      case 'โปรโมชั่น':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            createFlatButtonWithIcon(
                text: 'สร้างโปรโมชั่น',
                icon: Icons.add,
                color: Config.lightColor,
                press: () => null)
          ],
        );
        break;
      case 'ตั้งค่าร้าน':
        return Container();
        break;
      default:
        return Container();
        break;
    }
  }
}
