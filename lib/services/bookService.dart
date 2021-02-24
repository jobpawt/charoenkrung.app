import 'dart:convert';
import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/bookData.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:http/http.dart' as Http;

class BookService {
  static Future<ServerResponse> create({BookData data, String token}) async {
    var response = await Http.post(
      '${Config.DATABASE}/book/create',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data.toJson()),
    );
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }
}
