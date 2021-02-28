import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/buyData.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/providers/orderProvider.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/user/components/shop/shopAdd.dart';
import 'package:charoenkrung_app/services/buyService.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Options extends StatelessWidget {
  final DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context).menu;
    var user = Provider.of<UserProvider>(context).user;
    var provider = Provider.of<ShopProvider>(context, listen: false);
    var orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return _createOptions(context, menu, provider, user, orderProvider);
  }

  Widget _createOptions(BuildContext context, String menu,
      ShopProvider provider, UserData user, OrderProvider orderProvider) {
    switch (menu) {
      case 'ออร์เดอร์':
        return createFlatButton(
          text: 'เลือกวันที่',
          color: Config.primaryColor,
          press: () async {
            var picked = await showDatePicker(
                context: context,
                initialDate: time,
                firstDate: DateTime(2000),
                lastDate: DateTime(2025));
            if (picked != null) {
              var res = await BuyService.getAll(token: user.token);
              if (res.type != 'error') {
                var orderList = res.data as List<BuyData>;
                orderProvider.orders.clear();
                orderProvider.addAll(orderList.where((element) {
                  var date = DateTime.parse(element.date)
                      .toLocal()
                      .toString()
                      .split(' ')[0];
                  return date == picked.toLocal().toString().split(' ')[0];
                }).toList());
              }
            }
          },
        );
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
                          TextStyle(color: Config.primaryColor, fontSize: 18),
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
