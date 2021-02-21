import 'dart:convert';

class DayData {
  bool monday = true;
  bool tuesday = true;
  bool wednesday = true;
  bool thursday = true;
  bool friday = true;
  bool saturday = true;
  bool sunday = true;

  DayData();

  DayData.fromJson(String data) {
    var myDay = json.decode(data);
    this.monday = myDay['monday'];
    this.tuesday = myDay['tuesday'];
    this.wednesday = myDay['wednesday'];
    this.thursday = myDay['thursday'];
    this.friday = myDay['friday'];
    this.saturday = myDay['saturday'];
    this.sunday = myDay['sunday'];
  }

  Map<String, bool> toJson() {
    Map<String, bool> data = new Map();
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    data['sunday'] = this.sunday;
    return data;
  }

}