import 'dart:convert';

import 'package:charoenkrung_app/config/config.dart';
import 'package:charoenkrung_app/data/paymentData.dart';
import 'package:charoenkrung_app/utils/response.dart';
import 'package:http/http.dart' as Http;

class PaymentService {
  static Future<ServerResponse> create({PaymentData data, String token}) async {
    var response = await Http.post('${Config.DATABASE}/payment/create',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return ServerResponse(
          type: 'success',
          message: 'created payment',
          data: json.decode(response.body));
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }

  static Future<ServerResponse> get({String payment_id, String token}) async {
    var response = await Http.get(
      '${Config.DATABASE}/payment/$payment_id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 206) {
      var data = PaymentData.fromJson(json.decode(response.body));
      return ServerResponse(data: data);
    } else {
      return ServerResponse.fromJson(json.decode(response.body));
    }
  }
}
