class ShopData {
  String sid;
  String uid;
  String name;
  String address;
  // ignore: non_constant_identifier_names
  String open;
  String phone;
  String url;
  String status;
  String bank;

  ShopData(
      {this.sid,
      this.uid,
      this.name,
      this.address,
      // ignore: non_constant_identifier_names
      this.open,
      this.phone,
      this.url,
      this.status,
      this.bank});

  ShopData.fromJson(Map<String, dynamic> json) {
    this.sid = json['sid'];
    this.uid = json['uid'];
    this.name = json['name'];
    this.address = json['address'];
    this.open = json['open'];
    this.url = json['url'];
    this.status = json['status'];
    this.bank = json['bank'];
    this.phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['sid'] = this.sid;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['address'] = this.address;
    data['open'] = this.open.toString();
    data['url'] = this.url;
    data['status'] = this.status;
    data['bank'] = this.bank;
    data['phone'] = this.phone;
    return data;
  }
}
