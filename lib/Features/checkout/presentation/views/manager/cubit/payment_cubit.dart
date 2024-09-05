import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/payment_intent_input_model.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/payment_intent_model.dart';
import 'package:payment_gatway_app/Features/checkout/data/model/payment_intent_model/repos/chechout_repo.dart';


part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final ChechoutRepo checkoutRepo;

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel}) async{
      emit(PaymentLoading());

      var data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);

        data.fold(
          (L) => emit(PaymentFailure(L.errMessage)),
          (r) => emit(
            PaymentSuccess(),
          ),
        );
    }
    @override
  void onChange(Change<PaymentState> change) {
     log(change.toString());
     super.onChange(change);
  }
}
