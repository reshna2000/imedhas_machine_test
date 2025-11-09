import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

import '../style/colors_class.dart';



class SnackBars {
  static void otpSuccessBar(BuildContext context) {
    IconSnackBar.show(
      backgroundColor: Palette.kPrimary,
        context,
        label: 'Successfully Verified OTP',
        snackBarType: SnackBarType.success,);
  }

  static void otpSendBar(BuildContext context, String mobileNumber, Color bgColor) {
    IconSnackBar.show(

      backgroundColor:bgColor,

        context,
        label: 'Sending OTP to $mobileNumber',
        snackBarType: SnackBarType.success,);
  }

  static void resendingOtp(BuildContext context, String mobileNumber, Color bgColor) {
    IconSnackBar.show(

        backgroundColor:bgColor,

        context,
        label: 'ReSending OTP To $mobileNumber',
        snackBarType: SnackBarType.success,);
  }

  static void custom(BuildContext context,{String text = "", Color bgColor = Palette.kPrimary , SnackBarType type = SnackBarType.success}) {
    IconSnackBar.show(

        backgroundColor:bgColor,

        context,
        label: text,
        snackBarType:type,);
  }
}
