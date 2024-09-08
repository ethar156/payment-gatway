import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/manager/cubit/payment_cubit.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/my_cart_view.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/widgets/thank_you_view.dart';
import 'package:payment_gatway_app/core/utils/api_keys.dart';
import 'package:payment_gatway_app/core/widgets/custom_button.dart';


class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
   
  });

  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const ThankYouView();
          }));
        }

        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.errMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
            onTap: () {
            PaymentIntentInputModel paymentIntentInputModel = 
                 PaymentIntentInputModel( amount: '100', currency: 'USD', customerId: 'cus_QnF7ZE84Ymyi50');
                 BlocProvider.of<PaymentCubit>(context).makePayment(
                  paymentIntentInputModel: paymentIntentInputModel);
            },
            isLoading: state is PaymentLoading ? true : false,
            text: 'Continue');
      },
    );
  }

  void excuteStripePayment(BuildContext context) {
    PaymentIntentInputModel paymentIntentInputModel = PaymentIntentInputModel(
      amount: '100',
      currency: 'USD',
      customerId: 'cus_QnF7ZE84Ymyi50',
    );
    BlocProvider.of<PaymentCubit>(context)
        .makePayment(paymentIntentInputModel: paymentIntentInputModel);
  }


  }
    
    
  