import 'package:flutter/material.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/widgets/custom_button_bloc_consumer.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/widgets/payment_method_list_view.dart';
import 'package:payment_gatway_app/core/widgets/custom_button.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  


  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(),
          SizedBox(
            height: 32
            ,
          ),
          customButtonBlocConsumer(),
        
           SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

