import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/repos/checkout_repo_implementation.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/manager/cubit/payment_cubit.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/widgets/cart_info_item.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/widgets/payment_method_list_view.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/widgets/payment_methods_bottom_sheet.dart';
import 'package:payment_gatway_app/Features/checkout/presentation/views/widgets/total_price_widget.dart';
import 'package:payment_gatway_app/core/widgets/custom_button.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Expanded(child: Image.asset('assets/images/basket_image.png')),
          const SizedBox(
            height: 100,
          ),
          const OrderInfoItem(
            title: 'Order Subtotal',
            value: r'42.97$',
          ),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(
            title: 'Discount',
            value: r'0$',
          ),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(
            title: 'Shipping',
            value: r'8$',
          ),
          const Divider(
            thickness: 2,
            height: 34,
            color: Color(0xffC7C7C7),
          ),
          const TotalPrice(title: 'Total', value: r'$50.97'),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
              text: 'Complete Payment',
              onTap: () {
              
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    builder: (Context) {
                      return BlocProvider(
                        create: (context) => PaymentCubit(CheckoutRepoImplementation()),
                        child: const PaymentMethodsBottomSheet(),
                      );
                    });
              }),
          const SizedBox(
            height: 12,
          )
        ],
      ),
    );
  }
}
