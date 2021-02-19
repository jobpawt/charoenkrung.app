import 'dart:convert';
import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/preOrderData.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:http/http.dart' as Http;

class PreOrderService {
  static Future<ServerResponse> create(
      PreOrderData preOrder, String token) async {
    var response = await Http.post('${Config.DATABASE}/pre/create',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(preOrder.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> getAll() async {
    var response = await Http.get('${Config.DATABASE}/pre/all',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    if (response.statusCode == 206) {
      List<dynamic> data = json.decode(response.body);
      List<PreOrderData> preOrderList = new List();
      data.forEach((element) {
        var preOrder = PreOrderData.fromJson(element);
        preOrderList.add(preOrder);
      });
      return ServerResponse(data: preOrderList);
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> edit(
      PreOrderData preOrder, String token) async {
    var response =
        await Http.patch('${Config.DATABASE}/pre/edit/${preOrder.pre_id}',
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode(preOrder.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else if (response.statusCode == 404) {
      return ServerResponse(type: 'error', message: '404', data: null);
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> delete(PreOrderData preOrder, String token) async {
    preOrder.status = 'DELETED';
    var response =
    await Http.patch('${Config.DATABASE}/pre/edit/${preOrder.pre_id}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(preOrder.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }
}
