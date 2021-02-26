class RealtimeData {
  String type;
  Map<String, dynamic> data;
  String message;

  RealtimeData({this.type, this.data});

  RealtimeData.fromJson(Map<String, dynamic> json){
    this.type = json['type'];
    this.data = json['data'];
    this.message = json['message'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['type'] = this.type;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}