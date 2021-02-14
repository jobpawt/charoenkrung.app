class UserData {
  String uid;
  String email;
  String phone;
  String role;
  String password;
  String token;

  UserData({this.uid, this.email, this.phone, this.role, this.token});

  UserData.formJson(Map<String, dynamic> json) {
    this.uid = json['uid'];
    this.email = json['email'];
    this.phone= json['tel'];
    this.role = json['role'];
    this.token = json['token'];
    this.password = json['password'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['role'] = this.role;
    return data;
  }
}
