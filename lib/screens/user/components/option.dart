import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/screens/user/components/shop/shopAdd.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context).menu;
    return _createOptions(context, menu);
  }

  Widget _createOptions(BuildContext context, String menu) {
    switch (menu) {
      case 'ออร์เดอร์':
        return Container();
        break;
      case 'จอง':
        return Container();
        break;
      case 'ประวัติ':
        return Container();
        break;
      case 'ร้านของฉัน':
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ShopAdd())),
                    child: Text(
                      'สร้างร้าน',
                      style:
                          TextStyle(color: Config.primaryColor, fontSize: 14),
                    )),
              ],
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }
}
