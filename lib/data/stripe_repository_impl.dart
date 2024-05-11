import 'package:storeapi/data/source/network/api_stripe.dart';
import 'package:storeapi/domain/repository/stripe_repository.dart';

class StripeRepositoryImpl implements StripeRepository {
  final ApiStripe _api;

  StripeRepositoryImpl({
    required ApiStripe api,
  })  : _api = api;

  @override
  dynamic pagarStripe(String amount, String currency,String token,String descripcion)async {
    return await _api.pagarStripe(amount, currency, token,descripcion);
  }

}