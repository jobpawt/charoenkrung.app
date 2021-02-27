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

  static Future<ServerResponse> getAll({String token}) async {
    var response = await Http.get(
      '${Config.DATABASE}/book/all',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 206) {
      List<dynamic> data = json.decode(response.body);
      List<BookData> bookList= new List();
      data.forEach((element) {
        var preOrder = BookData.fromJson(element);
        bookList.add(preOrder);
      });
      return ServerResponse(data: bookList);
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> edit({BookData data, String token}) async {
    data.date = data.date.split('T')[0];
    var response =
    await Http.patch('${Config.DATABASE}/book/edit/${data.book_id}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

}
