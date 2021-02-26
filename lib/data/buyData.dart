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
    this.status
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