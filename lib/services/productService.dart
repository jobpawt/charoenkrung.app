import 'dart:convert';

import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/productData.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:http/http.dart' as Http;

class ProductService {
  static Future<ServerResponse> create(
      {ProductData product, String token}) async {
    var response = await Http.post('${Config.DATABASE}/product/create',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(product.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> getAll() async {
    var response = await Http.get('${Config.DATABASE}/product/all',
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 206) {
      List<dynamic> data = json.decode(response.body);
      List<ProductData> products = new List();
      data.forEach((element) {
        var product = ProductData.fromJson(element);
        // add product to products when status is not equal DELETED
        if(product.status != 'DELETED'){
          products.add(product);
        }
      });
      return ServerResponse(data: products);
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> edit(ProductData product, String token) async {
    var response =
    await Http.patch('${Config.DATABASE}/product/edit/${product.pid}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(product.toJson()));
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> delete(ProductData data, String token) async {
    var response = await Http.delete(
        '${Config.DATABASE}/product/delete/${data.pid}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      return null;
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

}