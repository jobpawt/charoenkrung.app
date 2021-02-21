import 'dart:convert';

import 'package:charoenkrung_app/data/shopData.dart';
import 'package:charoenkrung_app/data/userData.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:http/http.dart' as Http;
import 'package:charoenkrung_app/config/config.dart';

class ShopService {
  static Future<ServerResponse> create({ShopData shop, UserData user}) async {
    var response = await Http.post('${Config.DATABASE}/shop/create',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user.token}'
        },
        body: jsonEncode(shop.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> getAll() async {
    var response = await Http.get('${Config.DATABASE}/shop/all',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 206) {
      List<dynamic> data = json.decode(response.body);
      List<ShopData> shops = new List();
      data.forEach((element) {
        shops.add(ShopData.fromJson(element));
      });
      return ServerResponse(data: shops);
    } else if (response.statusCode == 404) {
      return ServerResponse(
          type: 'error', message: 'something went wrong', data: null);
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> edit({ShopData shop, String token}) async {
    var response = await Http.patch('${Config.DATABASE}/shop/edit/${shop.sid}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(shop.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(jsonDecode(response.body));
    }
  }
}
