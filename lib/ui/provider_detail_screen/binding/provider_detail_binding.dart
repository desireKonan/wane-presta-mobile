import 'package:handy/ui/provider_detail_screen/controller/provider_detail_controller.dart';
import 'package:get/get.dart';

class ProviderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderDetailController>(() => ProviderDetailController());
  }
}
