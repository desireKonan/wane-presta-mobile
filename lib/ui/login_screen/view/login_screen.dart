import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/login_screen/controller/login_screen_controller.dart';
import 'package:handy/ui/login_screen/widget/login_screen_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/constant.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryAppColor1,
      body: GetBuilder<LoginScreenController>(
        id: Constant.idCheckCustomer,
        builder: (logic) {
          return ProgressDialog(
            inAsyncCall: logic.isLoading,
            child: const LoginAddInfoView(),
          );
        },
      ),
    );
  }
}
