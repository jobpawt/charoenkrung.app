class DayData {
  Map<String, dynamic> days = {
    "จันทร์": true,
    "อังคาร": true,
    "พุธ": true,
    "พฤหัสบดี": true,
    "ศุกร์": true,
    "เสาร์": true,
    "อาทิตย์": true
  };

  DayData();

  DayData.fromJson(Map<String, dynamic> json) {
    this.days = json['open_days'];
  }

  Map<String, dynamic> get day {
    return this.days;
  }

}