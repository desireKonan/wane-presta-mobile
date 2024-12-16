import 'package:flutter/material.dart';
import 'package:handy/ui/category_detail_screen/widget/category_detail_widget.dart';
import 'package:handy/utils/app_color.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const CategoryDetailAppBarView(),
      ),
      body: const CategoryDetailListView(),
    );
  }
}
