import 'package:flutter/material.dart';

import 'payment_method_item.dart';

class PaymentMethodsListView extends StatefulWidget {
  const PaymentMethodsListView({super.key});

  @override
  State<PaymentMethodsListView> createState() => _PaymentMethodsListViewState();
}

class _PaymentMethodsListViewState extends State<PaymentMethodsListView> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = 0; 
                });
              },
              child: PaymentMethodItem(
                isActive: activeIndex == 0,
                image: 'assets/images/card.svg',
              ),
            ),
            const SizedBox(width: 24),
            GestureDetector(
              onTap: () {
                setState(() {
                  activeIndex = 1; 
                });
              },
              child: PaymentMethodItem(
                isActive: activeIndex == 1,
                image: 'assets/images/paypal.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
