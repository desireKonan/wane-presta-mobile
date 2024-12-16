import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/booking_information_screen/controller/booking_information_controller.dart';
import 'package:handy/ui/booking_information_screen/widget/booking_information_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/shimmers.dart';

class BookingInformationScreen extends StatelessWidget {
  const BookingInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingInformationController>(
      id: Constant.idGetAppointmentInfo,
      builder: (logic) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: const BookingInfoAppBarView(),
          ),
          bottomNavigationBar: logic.isLoading ? const SizedBox() : const BookingInformationBottomView(),
          body: SingleChildScrollView(
            child: logic.isLoading
                ? Shimmers.bookingInfoShimmer()
                : const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BookingInfoDoctorDataView(),
                      BookingInfoAppointmentView(),
                      BookingInfoPaymentView(),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
