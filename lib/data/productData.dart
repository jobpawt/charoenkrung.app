class ProductData{
  String pid;
  String sid;
  String name;
  String url;
  String description;
  int stock;
  int price;
  String status;
  // ignore: non_constant_identifier_names
  int type_id;
  String type_name;
  String shop_name;
  String shop_status;

  ProductData(
      {this.pid,
      this.sid,
      this.name,
      this.url,
      this.description,
      this.stock,
      this.price,
      this.status,
      // ignore: non_constant_identifier_names
      this.type_id,});

  ProductData.fromJson(Map<String, dynamic> json) {
    this.pid = json['pid'];
    this.sid = json['sid'];
    this.name = json['name'];
    this.url = json['url'];
    this.description = json['description'];
    this.stock = json['stock'];
    this.price = json['price'];
    this.status = json['status'];
    this.type_id = json['type_id'];
    this.type_name = json['type_name'];
    this.shop_name = json['shop_name'];
    this.shop_status = json['shop_status'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['pid'] = this.pid;
    data['sid'] = this.sid;
    data['name'] = this.name;
    data['url'] = this.url;
    data['description'] = this.description;
    data['stock'] = this.stock;
    data['price'] = this.price;
    data['status'] = this.status;
    data['type_id'] = this.type_id;
    return data;
  }
}
