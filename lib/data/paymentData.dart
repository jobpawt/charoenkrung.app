class PaymentData {
  // ignore: non_constant_identifier_names
  String payment_id;
  String type;
  String url;
  String status;

  // ignore: non_constant_identifier_names
  PaymentData({this.payment_id, this.type, this.url, this.status});

  PaymentData.fromJson(Map<String, dynamic> json) {
    this.payment_id = json['payment_id'];
    this.type = json['type'];
    this.url = json['url'];
    this.status = json['status'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['payment_id'] = this.payment_id;
    data['type'] = this.type;
    data['url'] = this.url;
    data['status'] = this.status;
    return data;
  }
}
