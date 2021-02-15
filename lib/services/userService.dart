import 'dart:convert';

import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/utils/response.dart';

import 'package:http/http.dart' as Http;
import 'package:charoenkrung_app/config/config.dart';

class UserService {
  static Future<ServerResponse> login(UserData user) async {
    var response = await Http.post('${Config.DATABASE}/user/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user.toJson()));
    if (response.statusCode != 206) {
      //have some error
      var error = ServerResponse.fromJson(jsonDecode(response.body));
      return error;
    } else {
      return ServerResponse(
          message: 'login sucess',
          status: 206,
          data: UserData.formJson(jsonDecode(response.body)));
    }
  }

  static Future<ServerResponse> register(UserData user) async {
    var response = await Http.post('${Config.DATABASE}/user/create',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(user.toJson()));
    if (response.statusCode != 201) {
      //have some error
      var error = ServerResponse.fromJson(jsonDecode(response.body));
      return error;
    } else {
      return ServerResponse(message: 'created', status: 201, data: null);
    }
  }

}
