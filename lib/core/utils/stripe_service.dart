import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/payment_intent_model.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/widgets/payment_details.dart';
import 'package:payment_gatway_app/core/utils/api_keys.dart';
import 'package:payment_gatway_app/core/utils/api_service.dart';

class StripeService
{
  final String secretkey = ''; 
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent
  (PaymentIntentInputModel paymentIntentInputModel)
  async{
    var response = await apiService.post(
      body:paymentIntentInputModel.toJson(),
      ContentType: Headers.formUrlEncodedContentType,
     url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretkey,);  
      var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

      return paymentIntentModel; 
  }

  Future initPaymentSheet({required String paymentIntentClientSecret})async{
    Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'ethar',
      ));
  }
  Future displayPaymentSheet() async{
    Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
    {required PaymentIntentInputModel paymentIntentInputModel})
    async{
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(
      paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();  
  }

  Future<PaymentIntentModel> createEphemeralkey
  (PaymentIntentInputModel paymentIntentInputModel)
  async{
    var response = await apiService.post(
      body:paymentIntentInputModel.toJson(),
      ContentType: Headers.formUrlEncodedContentType,
     url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretkey,);  
      var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

      return paymentIntentModel; 
  }
}