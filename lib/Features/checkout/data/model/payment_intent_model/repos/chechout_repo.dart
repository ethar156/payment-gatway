import 'package:dartz/dartz.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_gatway_app/core/errors/failures.dart';

abstract class ChechoutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel
  });
}

