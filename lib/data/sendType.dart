class SendTypeData {
  // ignore: non_constant_identifier_names
  String send_type_id;
  String type;

  // ignore: non_constant_identifier_names
  String recive_date;
  String position;
  String address;
  String phone;

  SendTypeData(
      // ignore: non_constant_identifier_names
      {this.send_type_id,
      this.type,
      // ignore: non_constant_identifier_names
      this.recive_date,
      this.position,
      this.address,
      this.phone});

  SendTypeData.fromJson(Map<String, dynamic> json) {
    this.send_type_id = json['send_type_id'];
    this.type = json['type'];
    this.recive_date = json['recive_date'];
    this.position = json['position'];
    this.address = json['address'];
    this.phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['send_type_id'] = this.send_type_id;
    data['type'] = this.type;
    data['recive_date'] = this.recive_date;
    data['position'] = this.position;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}
