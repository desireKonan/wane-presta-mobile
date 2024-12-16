import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/top_rated_worker_screen/controller/top_rated_worker_controller.dart';
import 'package:get/get.dart';

class TopRatedWorkerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopRatedWorkerController>(() => TopRatedWorkerController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
