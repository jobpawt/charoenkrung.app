import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/screens/home/components/buy/buy.dart';
import 'package:charoenkrung_app/utils/button.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductData product;

  ProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    return createItemPanel(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showImage(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: Config.kPadding),
                      child: Text(
                        product.name,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: Config.kPadding),
                      child: Text(
                        product.description,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          '${product.price} บาท',
                          style:
                              TextStyle(color: Config.darkColor, fontSize: 16),
                        ),
                        createFlatButton(
                            text: 'ซื้อ',
                            color: Colors.pink,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Buy(
                                    product: product,
                                    promotion: null,
                                  ),
                                ),
                              );
                            })
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
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
