class UserData {
  String uid;
  String email;
  String phone;
  String role;
  String password;
  String token;

  UserData(
      {this.uid, this.email, this.password, this.phone, this.role, this.token});

  UserData.formJson(Map<String, dynamic> json) {
    this.token = json['token'];
    this.uid = json['uid'];
    this.email = json['email'];
    this.password = json['password'];
    this.phone = json['phone'];
    this.role = json['role'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['token'] = this.token;
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['role'] = this.role;
    return data;
  }
}
