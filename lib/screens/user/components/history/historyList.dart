import 'package:charoenkrung_app/data/historyData.dart';
import 'package:charoenkrung_app/providers/bookProvider.dart';
import 'package:charoenkrung_app/providers/orderProvider.dart';
import 'package:charoenkrung_app/providers/preOrderProvider.dart';
import 'package:charoenkrung_app/providers/productProvider.dart';
import 'package:charoenkrung_app/providers/userProvider.dart';
import 'package:charoenkrung_app/screens/user/components/history/historyItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var historyList = List<HistoryData>();
    var buyList = Provider.of<OrderProvider>(context).orders;
    var bookList = Provider.of<BookProvider>(context).books;
    var productList = Provider.of<ProductProvider>(context).products;
    var preOrderList = Provider.of<PreOrderProvider>(context).preOrders;
    var user = Provider.of<UserProvider>(context).user;
    buyList.forEach((buy) {
      var index = productList.indexWhere((product) => product.pid == buy.pid);
      if (buy.uid == user.uid) {
        historyList.add(HistoryData(
            id: buy.buy_id,
            date: buy.date,
            amount: buy.amount,
            sum: buy.sum,
            name: 'ซื้อ ${productList[index].name}'));
      }
    });
    bookList.forEach((book) {
      var index =
          preOrderList.indexWhere((preOrder) => preOrder.pre_id == book.pre_id);
      if (book.uid == user.uid) {
        historyList.add(HistoryData(
            id: book.book_id,
            date: book.date,
            amount: book.amount,
            sum: book.sum,
            name: 'จอง ${preOrderList[index].name}'));
      }
    });
    return ListView.builder(
      itemCount: historyList.length,
      itemBuilder: (context, index) => HistoryItem(
        history: historyList[index],
      ),
    );
  }
}
