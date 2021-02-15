class ServerResponse{
  int status;
  String message;
  dynamic data;

  ServerResponse({this.status, this.message, this.data});

  ServerResponse.fromJson(Map<String, dynamic> json){
    this.status = int.parse(json['status'].toString());
    this.message = json['message'];
  }
}