import 'dart:convert';

import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/promotionData.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:http/http.dart' as Http;

class PromotionService {
  static Future<ServerResponse> create(
      PromotionData promotion, String token) async {
    var response = await Http.post('${Config.DATABASE}/promotion/create',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(promotion.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> getAll() async {
    var response = await Http.get('${Config.DATABASE}/promotion/all',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 206) {
      List<dynamic> data = json.decode(response.body);
      List<PromotionData> promotionList = new List();
      data.forEach((element) {
        var promotion = PromotionData.fromJson(element);
        promotionList.add(promotion);
      });
      return ServerResponse(data: promotionList);
    } else if (response.statusCode == 404) {
      return ServerResponse(
          type: 'error', message: '404 not found', data: null);
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> edit(
      PromotionData promotion, String token) async {
    var response =
    await Http.patch('${Config.DATABASE}/promotion/edit/${promotion.pro_id}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(promotion.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else if (response.statusCode == 404) {
      return ServerResponse(type: 'error', message: '404', data: null);
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> delete(PromotionData promotion, String token) async {
    promotion.status = 'DELETED';
    var response =
    await Http.patch('${Config.DATABASE}/promotion/edit/${promotion.pro_id}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(promotion.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

}
