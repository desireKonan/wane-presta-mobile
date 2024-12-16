import 'package:get/get.dart';
import 'package:handy/ui/category_detail_screen/controller/category_detail_controller.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';

class CategoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryDetailController>(() => CategoryDetailController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
