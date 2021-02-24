import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/data/promotionData.dart';
import 'package:charoenkrung_app/screens/home/components/buy/buy.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';

class PromotionItem extends StatelessWidget {
  final ProductData product;
  final PromotionData promotion;

  PromotionItem({this.product, this.promotion});

  @override
  Widget build(BuildContext context) {
    return createItemPanel(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            showImage(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '${promotion.name}',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  Text(
                    'ราคา ${promotion.price} บาท',
                    style: TextStyle(color: Config.primaryColor, fontSize: 14),
                  ),
                  buildTimeLeft()
                ],
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: createFlatButton(
              text: 'ซื้อเลย',
              color: Colors.pink,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Buy(
                              product: product,
                              promotion: promotion,
                            )));
              }),
        )
      ],
    ));
  }

  Widget buildTimeLeft() {
    DateTime start = DateTime.parse(promotion.start);
    DateTime end = DateTime.parse(promotion.end);
    int left =
        end.difference(start).inDays - DateTime.now().difference(start).inDays;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Text.rich(TextSpan(style: TextStyle(fontSize: 12), children: [
            TextSpan(
                text: 'สิ้นสุด ${end.toLocal().day}/${end.month}/${end.year}'),
          ])),
        ),
        Text(
          left != 0 ? 'เหลือ $left วัน' : 'วันสุดท้าย',
          style: TextStyle(color: Config.darkColor),
        )
      ],
    );
  }

  Widget showImage() {
    return FutureBuilder(
        future: _getImageFromNetwork(product.url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data;
          } else {
            return Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Future<Widget> _getImageFromNetwork(String url) async {
    return Container(
      margin: EdgeInsets.all(Config.kMargin),
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Config.kRadius)),
          image: DecorationImage(
              image: NetworkImage('${Config.IMAGE}/$url'), fit: BoxFit.cover)),
    );
  }
}
