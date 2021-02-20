import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/promotionData.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/promotionProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/shop/components/promotion/promotionAdd.dart';
import 'package:charoenkrung_app/services/promotionService.dart';
import 'package:charoenkrung_app/utils/dialogBox.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PromotionItem extends StatelessWidget {
  final PromotionData promotion;

  PromotionItem({this.promotion});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PromotionProvider>(context, listen: false);
    var productList =
        Provider.of<ProductProvider>(context, listen: false).products;
    var user = Provider.of<UserProvider>(context, listen: false);

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
                'โปรโมชั่น ${promotion.name}',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            _buildTimeLeft(),
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
                    provider: provider,
                    promotion: promotion,
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
                          builder: (context) => PromotionAdd(
                              promotion: promotion,
                              provider: provider,
                              productList: productList)));
                })
          ],
        )
      ],
    ));
  }

  _delete(
      {PromotionData promotion,
      PromotionProvider provider,
      String token}) async {
    var start = DateTime.parse(promotion.start);
    var end = DateTime.parse(promotion.end);
    promotion.start = start.toLocal().toString().split(' ')[0];
    promotion.end = end.toLocal().toString().split(' ')[0];
    await PromotionService.delete(promotion, token).then((value) {
      if (value == null) {
        provider.remove(promotion);
      }
    });
  }

  Widget _buildTimeLeft() {
    DateTime start = DateTime.parse(promotion.start);
    DateTime end = DateTime.parse(promotion.end);
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
