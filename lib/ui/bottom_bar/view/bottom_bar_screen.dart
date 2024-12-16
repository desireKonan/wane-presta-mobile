import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:handy/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:handy/ui/bottom_bar/widget/bottom_bar_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      id: Constant.idBottomBar,
      builder: (logic) {
        return Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: const BottomBarView(),
          body: logic.pages[logic.selectIndex],
        );
      },
    );
  }
}
