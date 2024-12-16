import 'package:get/get.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/saved_provider_screen/controller/saved_provider_controller.dart';

class SavedProviderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavedProviderController>(() => SavedProviderController(), fenix: true);
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
