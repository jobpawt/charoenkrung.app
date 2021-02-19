import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/preOrderData.dart';
import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/preorder/preOrderAdd.dart';
import 'package:charoenkrung_app/services/preOrderService.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PreOrderItem extends StatelessWidget {
  final PreOrderData preOrder;
  final String sid;

  PreOrderItem({this.preOrder, this.sid});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PreOrderProvider>(context);
    var user = Provider.of<UserProvider>(context);

    return createItemPanel(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                preOrder.name,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            buildTimeLeft()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: SvgPicture.asset(
                  'assets/delete.svg',
                  color: Config.primaryColor,
                  height: 25,
                ),
                onPressed: () => _delete(
                    preOrder: preOrder,
                    provider: provider,
                    token: user.user.token)),
            IconButton(
                icon: SvgPicture.asset(
                  'assets/edit.svg',
                  color: Config.primaryColor,
                  height: 30,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreOrderAdd(
                              sid: sid,
                              preOrder: preOrder,
                              provider: provider)));
                })
          ],
        )
      ],
    ));
  }

  _delete(
      {PreOrderData preOrder, PreOrderProvider provider, String token}) async {
    var start = DateTime.parse(preOrder.start);
    var end = DateTime.parse(preOrder.end);
    preOrder.start = start.toLocal().toString().split(' ')[0];
    preOrder.end = end.toLocal().toString().split(' ')[0];
    await PreOrderService.delete(preOrder, token).then((value) {
      if (value == null) {
        provider.remove(preOrder);
      }
    });

  }

  Widget buildTimeLeft() {
    DateTime start = DateTime.parse(preOrder.start);
    DateTime end = DateTime.parse(preOrder.end);
    int left =
        end.difference(start).inDays - DateTime.now().difference(start).inDays;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(TextSpan(style: TextStyle(fontSize: 12), children: [
            TextSpan(
                text:
                    'เริ่มวันที่ ${start.toLocal().day}/${start.month}/${start.year} - '),
            TextSpan(
                text:
                    'สิ้นสุด ${end.toLocal().day}/${end.month}/${end.year}\n'),
          ])),
        ),
        Center(
          child: Text(
            'เหลือ $left วัน',
            style: TextStyle(color: Config.accentColor),
          ),
        )
      ],
    );
  }
}
