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

  BookData(
      // ignore: non_constant_identifier_names
      {this.book_id,
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
      this.status});

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
