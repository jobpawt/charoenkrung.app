import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/preOrderData.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';

class PreOrderItem extends StatelessWidget {
  final PreOrderData preOrder;

  PreOrderItem({this.preOrder});

  @override
  Widget build(BuildContext context) {
    return createItemPanel(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showImage(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    preOrder.name,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      preOrder.description,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  buildTimeLeft(),
                ],
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: createFlatButton(
              color: Colors.pink, text: 'จอง', press: () => null),
        )
      ],
    ));
  }

  Widget buildTimeLeft() {
    DateTime start = DateTime.parse(preOrder.start);
    DateTime end = DateTime.parse(preOrder.end);
    int left =
        end.difference(start).inDays - DateTime.now().difference(start).inDays;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 0,
          ),
          child: Text.rich(TextSpan(style: TextStyle(fontSize: 12), children: [
            TextSpan(
                text:
                    'สิ้นสุด ${end.toLocal().day}/${end.month}/${end.year}'),
          ])),
        ),
        Text(
          'เหลือ $left วัน',
          style: TextStyle(color: Config.darkColor),
        )
      ],
    );
  }

  Widget showImage() {
    return FutureBuilder(
        future: _getImageFromNetwork(preOrder.url),
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
