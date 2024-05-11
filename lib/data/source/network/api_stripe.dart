import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiStripe {
  Future<Map<String, dynamic>> pagarStripe(String amount, String currency,String token,String descripcion);
}

class ApiStripeImpl implements ApiStripe {
  String urlGeneral = "https://api.stripe.com/v1/";
  final dio = Dio();


  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  @override
  Future<Map<String, dynamic>> pagarStripe(String amount, String currency,String token,String descripcion) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'source': token,
        'description': descripcion,
      };

      //Make post request to Stripe
      final urlCompuesta = "${urlGeneral}charges";
      dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
      dio.options.headers["Authorization"] = "Bearer ${dotenv.env['STRIPE_SECRET']}";
      final response = await dio.post(
        urlCompuesta,
        data: body,
      );
      log("Stripe -> ${response.data}");
      return response.data;
    } catch (err,stack) {
      print(stack);
      throw Exception(err.toString());
    }
  }

}