import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/providers/bookProvider.dart';
import 'package:charoenkrung_app/providers/menuProvider.dart';
import 'package:charoenkrung_app/providers/orderProvider.dart';
import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/shopProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/user/components/book/bookList.dart';
import 'package:charoenkrung_app/screens/user/components/history/historyList.dart';
import 'package:charoenkrung_app/screens/user/components/order/orderList.dart';
import 'package:charoenkrung_app/screens/user/components/shop/shopList.dart';
import 'package:charoenkrung_app/services/bookService.dart';
import 'package:charoenkrung_app/services/buyService.dart';
import 'package:charoenkrung_app/services/preOrderService.dart';
import 'package:charoenkrung_app/services/productService.dart';
import 'package:charoenkrung_app/services/shopService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    _getAllShop();
    _getAllOrder();
    _getAllProduct();
    _getAllPreOrder();
    _getAllBook();
  }

  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context);
    var user = Provider.of<UserProvider>(context);
    return Expanded(child: checkBody(menu.menu, user.user));
  }

  Widget checkBody(String menu, UserData user) {
    switch (menu) {
      case 'ออร์เดอร์':
        return OrderList(user: user);
        break;
      case 'จอง':
        return BookList();
        break;
      case 'ประวัติ':
        return HistoryList();
        break;
      case 'ร้านของฉัน':
        return ShopList();
        break;
      default:
        return Container();
        break;
    }
  }

  _getAllBook() async {
    var token = Provider.of<UserProvider>(context, listen: false).user.token;
    await BookService.getAll(token: token).then((value) {
      if (value.type != 'error') {
        Provider.of<BookProvider>(context, listen: false).addAll(value.data);
      }
    });
  }

  _getAllPreOrder() async {
    await PreOrderService.getAll().then((preOrders) {
      if (preOrders.type != 'error') {
        Provider.of<PreOrderProvider>(context, listen: false)
            .addAll(preOrders.data);
      }
    });
  }

  _getAllProduct() async {
    await ProductService.getAll().then(
      (products) {
        if (products.type != 'error') {
          Provider.of<ProductProvider>(context, listen: false)
              .addAll(products.data);
        }
      },
    );
  }

  _getAllShop() async {
    await ShopService.getAll().then((res) async {
      if (res.type != 'error') {
        var shopList = res.data as List<ShopData>;
        List<ShopData> myShop =
            shopList.where((element) => element.status != 'DELETED').toList();
        Provider.of<ShopProvider>(context, listen: false).addAll(myShop);
      }
    });
  }

  _getAllOrder() async {
    var token = Provider.of<UserProvider>(context, listen: false).user.token;
    await BuyService.getAll(token: token).then((value) {
      if (value.type != 'error') {
        Provider.of<OrderProvider>(context, listen: false).addAll(value.data);
      }
    });
  }
}
