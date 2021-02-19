class PreOrderData {
  String pre_id;
  String sid;
  String name;
  String description;
  String url;
  int price;
  int stock;
  String start;
  String end;
  String status;

  PreOrderData(
      {this.pre_id,
        this.sid,
        this.name,
        this.description,
        this.url,
        this.price,
        this.stock,
        this.start,
        this.end,
        this.status
      });

  PreOrderData.fromJson(Map<String, dynamic> json) {
    this.pre_id = json['pre_id'];
    this.sid = json['sid'];
    this.name = json['name'];
    this.description = json['description'];
    this.url = json['url'];
    this.price = json['price'];
    this.stock = json['stock'];
    this.start = json['start'];
    this.end = json['end'];
    this.status = json['status'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['pre_id'] = this.pre_id;
    data['sid'] = this.sid;
    data['name'] = this.name;
    data['description'] = this.description;
    data['url'] = this.url;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['start'] = this.start;
    data['end'] = this.end;
    data['status'] = this.status;
    return data;
  }
}