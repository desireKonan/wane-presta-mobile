import 'package:flutter/material.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/ui/booking_screen/widget/booking_screen_widget.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const BookingAppBarView(),
      ),
      bottomNavigationBar: const BookingBottomView(),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingInfoView(),
            BookingDateView(),
            BookingSlotView(),
            BookingProblemView(),
            BookingUploadPhotoView(),
          ],
        ),
      ),
    );
  }
}
