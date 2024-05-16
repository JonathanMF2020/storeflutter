import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:storeapi/domain/repository/stripe_repository.dart';

class PagarProductos {
  PagarProductos({
    required StripeRepository repository,
  }) : _repository = repository;

  final StripeRepository  _repository;

  Future<bool> call({required CardDetails detail, required double total}) async {
    return stripeMakePayment(detail,total);
  }

  Future<bool> stripeMakePayment(CardDetails detail,double total) async {
    try {
      CardTokenParams cardParams = CardTokenParams(type: TokenType.Card, name:"Card${detail.number}",);
      Stripe.instance.dangerouslyUpdateCardDetails(detail);
      TokenData token = await Stripe.instance.createToken(CreateTokenParams.card(params: cardParams),);
      String tokenid = token.id;
      var paymentIntent = await _repository.pagarStripe(total.toStringAsFixed(0), 'MXN',tokenid,"Descripcion de prueba");
      final respuesta = await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              billingDetails: const BillingDetails(
                  name: 'Jonathan Mojica',
                  email: 'jonathanmojicafernandezdev@gmail.com',
                  phone: '454543223',
                  address: Address(
                      city: 'LEON',
                      country: 'MÉXICO',
                      line1: 'Federico Guillermo Raifeeisen 208',
                      line2: 'Federico Guillermo Raifeeisen 208',
                      postalCode: '37219',
                      state: 'GUANAJUATO')),
              paymentIntentClientSecret: paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,

              merchantDisplayName: 'Ikay'));

      if(paymentIntent["status"] ==  "succeeded"){
        return true;
      }else{
        return false;
      }

    } catch (e,stack) {
      print(stack);
      print(e.toString());
      return false;
      // TODO: Manejo de errores en vista
    }
  }


}