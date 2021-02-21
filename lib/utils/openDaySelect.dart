import 'package:charoenkrung_app/data/dayData.dart';
import 'package:flutter/material.dart';
import 'package:charoenkrung_app/config/config.dart';

class OpenDaySelect extends StatefulWidget {
  final DayData days;

  OpenDaySelect({this.days});

  @override
  _OpenDaySelectState createState() => _OpenDaySelectState();
}

class _OpenDaySelectState extends State<OpenDaySelect> {
  Map<String, bool> openDays;

  @override
  void initState() {
    openDays = widget.days.toJson();
    super.initState();
  }

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
              children: openDays.entries
                  .map((value) => radioButton(value.key, value.value))
                  .toList())
        ],
      ),
    );
  }

  Widget radioButton(String day, bool status) {
    return GestureDetector(
      onTap: () {
        setState(() {
          //days.days[day] = !status;
          openDays[day] = !status;
          switch (day) {
            case 'monday':
              widget.days.monday = !status;
              break;
            case 'tuesday':
              widget.days.tuesday = !status;
              break;
            case 'wednesday':
              widget.days.wednesday = !status;
              break;
            case 'thursday':
              widget.days.thursday = !status;
              break;
            case 'friday':
              widget.days.friday = !status;
              break;
            case 'saturday':
              widget.days.saturday = !status;
              break;
            case 'sunday':
              widget.days.sunday = !status;
              break;
          }
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
              child: Text(
                tranDayToThai(day),
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  String tranDayToThai(String day) {
    switch (day) {
      case 'monday':
        return 'จันทร์';
        break;
      case 'tuesday':
        return 'อังคาร';
        break;
      case 'wednesday':
        return 'พุธ';
        break;
      case 'thursday':
        return 'พฤหัสบดี';
        break;
      case 'friday':
        return 'ศุกร์';
        break;
      case 'saturday':
        return 'เสาร์';
        break;
      case 'sunday':
        return 'อาทิตย์';
        break;
      default:
        return '';
        break;
    }
  }
}
