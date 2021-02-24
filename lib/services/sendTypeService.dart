import 'dart:convert';
import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/sendType.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:http/http.dart' as Http;

class SendTypeService {
  static Future<ServerResponse> create(
      {SendTypeData data, String token}) async {
    var response = await Http.post('${Config.DATABASE}/send/type/create',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(data.toJson()));

    if (response.statusCode == 200) {
      return ServerResponse(
          type: 'success',
          message: 'created send type',
          data: json.decode(response.body));
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }
}
