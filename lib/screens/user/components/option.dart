import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/screens/user/components/shop/shopAdd.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context).menu;
    var provider = Provider.of<ShopProvider>(context, listen: false);
    return _createOptions(context, menu, provider);
  }

  Widget _createOptions(
      BuildContext context, String menu, ShopProvider provider) {
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
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShopAdd(
                                  provider: provider,
                                ))),
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
