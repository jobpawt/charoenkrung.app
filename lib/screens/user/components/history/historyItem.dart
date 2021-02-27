import 'package:charoenkrung_app/data/historyData.dart';
import 'package:charoenkrung_app/utils/panel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  final HistoryData history;
  final formatter = NumberFormat('#,###');

  HistoryItem({this.history});

  @override
  Widget build(BuildContext context) {
    return createItemPanel(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          history.id,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          history.name,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        Text(
            'จำนนวน ${history.amount} รวมราคา ${formatter.format(history.sum)} บาท'),
        Text(
            'วันที่ ${DateTime.parse(history.date).toLocal().toString().split(' ')[0]}')
      ],
    ));
  }
}
