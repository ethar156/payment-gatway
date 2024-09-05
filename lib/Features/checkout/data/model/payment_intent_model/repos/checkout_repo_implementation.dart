import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/repos/chechout_repo.dart';
import 'package:payment_gatway_app/core/errors/failures.dart';
import 'package:payment_gatway_app/core/utils/stripe_service.dart';

class CheckoutRepoImplementation extends ChechoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment(
    {required PaymentIntentInputModel paymentIntentInputModel})async {
    try {
      await stripeService.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
      
    }
    throw UnimplementedError();
  }
  
}