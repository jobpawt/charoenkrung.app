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
}
