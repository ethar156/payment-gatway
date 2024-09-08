import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/init_payment_sheet_input_model.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/payment_intent_model.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/widgets/payment_details.dart';
import 'package:payment_gatway_app/core/utils/api_keys.dart';
import 'package:payment_gatway_app/core/utils/api_service.dart';

class StripeService {
  final String secretkey = ''; 
  final ApiService apiService = ApiService();
  
  Future<PaymentIntentModel> createPaymentIntent(PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretkey,
    );  
    
    return PaymentIntentModel.fromJson(response.data);
  }

  Future initPaymentSheet({required InitPaymentSheetInputModel initPaymentSheetInputModel}) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: initPaymentSheetInputModel.clientSecret,
          customerEphemeralKeySecret: initPaymentSheetInputModel.ephemeralKeySecret,
          customerId: initPaymentSheetInputModel.customerId,
          merchantDisplayName: 'ethar',
        ),
      );
      print("Payment sheet initialized");
    } catch (e) {
      print('Error initializing payment sheet: $e');
      rethrow;  // Rethrow if you want to handle it higher up.
    }
  }

  Future displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Payment sheet displayed successfully");
    } catch (e) {
      print('Error presenting payment sheet: $e');
      rethrow;
    }
  }

  Future makePayment({required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      // Step 1: Create Payment Intent
      var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);

      // Step 2: Create Ephemeral Key
      var ephemeralKeyModel = await createEphemeralkey(customerId: paymentIntentInputModel.customerId);

      // Step 3: Initialize Payment Sheet
      var initPaymentSheetInputModel = InitPaymentSheetInputModel(
        clientSecret: paymentIntentModel.clientSecret!,
        customerId: paymentIntentInputModel.customerId,
        ephemeralKeySecret: ephemeralKeyModel.secret!,
      );

      await initPaymentSheet(initPaymentSheetInputModel: initPaymentSheetInputModel);

      // Step 4: Present the Payment Sheet
      await displayPaymentSheet();

    } catch (e) {
      // Error Handling: Capture any issues during initialization or presentation
      print('Error: $e');
      // Optionally handle UI feedback for errors here
    }
  }

  Future<EphemeralKeyModel> createEphemeralkey({required String customerId}) async {
    var response = await apiService.post(
      body: {'customer': customerId},
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      token: ApiKeys.secretkey,
      headers: {
        'Authorization': "Bearer ${ApiKeys.secretkey}",
        'Stripe-version': '2024-06-20',
      },
    );
    
    return EphemeralKeyModel.fromJson(response.data);
  }
}
