import 'dart:developer';

import 'package:get/get.dart';
import 'package:handy/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';

class MyWalletController extends GetxController {
  ConfirmBookingController confirmBookingController = Get.find<ConfirmBookingController>();

  @override
  void onInit() async {
    confirmBookingController.amount = confirmBookingController.directAmount[0];
    confirmBookingController.currency = confirmBookingController.directAmount[0];
    confirmBookingController.currencyController.text = confirmBookingController.amount;

    log("Currency Controller :: ${confirmBookingController.currencyController.text}");

    super.onInit();
  }
}
