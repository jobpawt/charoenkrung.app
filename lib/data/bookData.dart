import 'dart:convert';

class BookData {
  // ignore: non_constant_identifier_names
  String book_id;
  String uid;

  // ignore: non_constant_identifier_names
  String pre_id;

  // ignore: non_constant_identifier_names
  String send_type_id;

  // ignore: non_constant_identifier_names
  String payment_id;
  int amount;
  int sum;
  String date;
  String status;
  String send_type;
  String sid;
  String recive_date;
  Map<String, dynamic> position;
  String address;
  String phone;
  String preOrder_name;
  String preOrder_status;
  String payment_type;
  String payment_url;
  String payment_status;

  BookData( // ignore: non_constant_identifier_names
      {
    this.book_id,
    this.uid,
    // ignore: non_constant_identifier_names
    this.pre_id,
    // ignore: non_constant_identifier_names
    this.send_type_id,
    // ignore: non_constant_identifier_names
    this.payment_id,
    this.amount,
    this.sum,
    this.date,
    this.status,
    this.send_type,
    this.sid,
    this.recive_date,
    this.position,
    this.address,
    this.phone,
    this.preOrder_name,
    this.preOrder_status,
    this.payment_type,
    this.payment_url,
    this.payment_status,
  });

  BookData.fromJson(Map<String, dynamic> json) {
    this.book_id = json['book_id'];
    this.uid = json['uid'];
    this.pre_id = json['pre_id'];
    this.send_type_id = json['send_type_id'];
    this.payment_id = json['payment_id'];
    this.amount = json['amount'];
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
    this.preOrder_name = json['preOrder_name'];
    this.preOrder_status = json['preOrder_status'];
    this.sid = json['sid'];
    this.payment_type = json['payment_type'];
    this.payment_url = json['payment_url'];
    this.payment_status = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['book_id'] = this.book_id;
    data['uid'] = this.uid;
    data['pre_id'] = this.pre_id;
    data['send_type_id'] = this.send_type_id;
    data['payment_id'] = this.payment_id;
    data['amount'] = this.amount;
    data['sum'] = this.sum;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}
