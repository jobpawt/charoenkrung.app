class ServerResponse{
  String type;
  int status;
  String message;
  dynamic data;

  ServerResponse({this.type, this.status, this.message, this.data});

  ServerResponse.fromJson(Map<String, dynamic> json){
    this.status = int.parse(json['status'].toString());
    this.message = json['message'];
    this.type = json['type'];
  }
}