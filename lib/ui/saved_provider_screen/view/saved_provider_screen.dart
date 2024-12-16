import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:handy/ui/saved_provider_screen/controller/saved_provider_controller.dart';
import 'package:handy/ui/saved_provider_screen/widget/saved_provider_widget.dart';
import 'package:handy/utils/app_color.dart';

class SavedProviderScreen extends StatelessWidget {
  const SavedProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedProviderController>(
      builder: (logic) {
        return PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (!didPop) {
              if (logic.isBack == false) {
                if (Navigator.canPop(context)) {
                  Get.back();
                }
              } else {
                Get.find<BottomBarController>().onClick(0);
              }
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: const SavedProviderAppBarView(),
            ),
            body: const SavedProviderListView(),
          ),
        );
      },
    );
  }
}
