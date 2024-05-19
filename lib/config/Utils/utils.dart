import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:food_reciepe_app/consant/use_colors.dart';

class Utils {
  static void flushBarMessage(
      String message, BuildContext context, bool isError) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: isError ? Colors.red : UseColors.successMessageColor,
        reverseAnimationCurve: Curves.easeInOut,
        messageColor: isError ? UseColors.textColor : UseColors.backgroundColor,
        positionOffset: 20,
        icon: Icon(
          isError ? Icons.error : Icons.check_circle,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }
}