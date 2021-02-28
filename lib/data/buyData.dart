import 'dart:convert';

class BuyData {
  // ignore: non_constant_identifier_names
  String buy_id;
  String uid;
  String pid;

  // ignore: non_constant_identifier_names
  String pro_id;

  // ignore: non_constant_identifier_names
  String payment_id;

  // ignore: non_constant_identifier_names
  String send_type_id;
  int amount;
  int sum;
  String date;
  String status;

  //another tables
  String send_type;
  String recive_date;
  Map<String, dynamic> position;
  String address;
  String phone;
  String product_name;
  String sid;
  String payment_type;
  String payment_url;
  String payment_status;
  String promotion_name;

  BuyData({
    // ignore: non_constant_identifier_names
    this.buy_id,
    this.uid,
    this.pid,
    // ignore: non_constant_identifier_names
    this.pro_id,
    // ignore: non_constant_identifier_names
    this.payment_id,
    // ignore: non_constant_identifier_names
    this.send_type_id,
    this.amount,
    this.sum,
    this.date,
    this.status,
    this.send_type,
    this.recive_date,
    this.position,
    this.address,
    this.phone,
    this.product_name,
    this.sid,
    this.payment_type,
    this.payment_url,
    this.payment_status,
    this.promotion_name,
  });

  BuyData.fromJson(Map<String, dynamic> json) {
    this.buy_id = json['buy_id'];
    this.uid = json['uid'];
    this.pid = json['pid'];
    this.payment_id = json['payment_id'];
    this.send_type_id = json['send_type_id'];
    this.amount = json['amount'];
    this.pro_id = json['pro_id'];
    this.sum = json['sum'];
    this.date = json['date'];
    this.status = json['status'];
    //another tables
    this.send_type = json['send_type'];
    this.recive_date = json['recive_date'];
    this.position =
        json['position'] == null ? Map() : jsonDecode(json['position']);
    this.address = json['address'];
    this.phone = json['phone'];
    this.product_name = json['product_name'];
    this.sid = json['sid'];
    this.payment_type = json['payment_type'];
    this.payment_url = json['payment_url'];
    this.payment_status = json['payment_status'];
    this.promotion_name = json['promotion_name'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['buy_id'] = this.buy_id;
    data['uid'] = this.uid;
    data['pid'] = this.pid;
    data['payment_id'] = this.payment_id;
    data['send_type_id'] = this.send_type_id;
    data['amount'] = this.amount;
    data['sum'] = this.sum;
    data['date'] = this.date;
    data['pro_id'] = this.pro_id;
    data['status'] = this.status;
    return data;
  }
}
