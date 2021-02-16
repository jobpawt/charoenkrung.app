import 'package:charoenkrung_app/data/dayData.dart';
import 'package:flutter/material.dart';
import 'package:charoenkrung_app/config/config.dart';

class OpenDaySelect extends StatefulWidget {
  final DayData days;

  OpenDaySelect({this.days});

  @override
  _OpenDaySelectState createState() => _OpenDaySelectState(days: days);
}

class _OpenDaySelectState extends State<OpenDaySelect> {
  final DayData days;

  _OpenDaySelectState({this.days});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: Config.kPadding),
            child: Text('วันเปิดบริการ',
                style: Theme.of(context).textTheme.subtitle2),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            primary: false,
            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            crossAxisSpacing: 2,
            mainAxisSpacing: 0,
            crossAxisCount: 4,
            children: days.days.entries
                .map((day) => radioButton(day.key, day.value))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget radioButton(String day, bool status) {
    return GestureDetector(
      onTap: () {
        setState(() {
          days.days[day] = !status;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.5),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Config.darkColor)),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status ? Config.accentColor : Colors.transparent),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 4),
              child: Text(day),
            )
          ],
        ),
      ),
    );
  }
}
