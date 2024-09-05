
import 'package:flutter/material.dart';
import 'package:payment_gatway_app/core/utils/styles.dart';


AppBar buildAppBar({final String? title}) {
  return AppBar(
    leading: Center(
      child: Image.asset('assets/images/arrow-left.png',
          scale: 15,),
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
      title ?? '',
      textAlign: TextAlign.center,
      style: Styles.style25,
    ),
  );
}