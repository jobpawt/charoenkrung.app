class PromotionData {
  // ignore: non_constant_identifier_names
  String pro_id;
  String pid;
  String name;
  int price;
  String start;
  String end;
  String status;

  PromotionData(
      // ignore: non_constant_identifier_names
      {this.pro_id,
      this.pid,
      this.name,
      this.price,
      this.start,
      this.end,
      this.status});

  PromotionData.fromJson(Map<String, dynamic> json) {
    this.pro_id = json['pro_id'];
    this.pid = json['pid'];
    this.name = json['name'];
    this.price = json['price'];
    this.start = json['start'];
    this.end = json['end'];
    this.status = json['status'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['pro_id'] = this.pro_id;
    data['pid'] = this.pid;
    data['name'] = this.name;
    data['price'] = this.price;
    data['start'] = this.start;
    data['end'] = this.end;
    data['status'] = this.status;
    return data;
  }
}
