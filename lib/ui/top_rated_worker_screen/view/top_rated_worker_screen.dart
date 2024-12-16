import 'package:get/get.dart';
import 'package:handy/ui/top_rated_worker_screen/widget/top_rated_worker_widget.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/app_color.dart';

class TopRatedWorkerScreen extends StatelessWidget {
  const TopRatedWorkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const TopRatedWorkerAppBarView(),
      ),
      body: const TopRatedWorkerListView().paddingOnly(top: 10, bottom: 10),
    );
  }
}
