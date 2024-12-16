import 'package:get/get.dart';
import 'package:handy/ui/mobile_number_screen/controller/mobile_number_controller.dart';

class MobileNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobileNumberController>(() => MobileNumberController());
  }
}
