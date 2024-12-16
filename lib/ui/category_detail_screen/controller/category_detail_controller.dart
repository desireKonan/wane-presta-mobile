import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/category_detail_screen/model/get_service_wise_provider_model.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class CategoryDetailController extends GetxController {
  String? serviceName;
  String? serviceId;
  dynamic args = Get.arguments;
  List<bool> isProviderSaved = [];

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();

    await getServiceWiseProviderApiCall(
      customerId: Constant.storage.read('customerId'),
      serviceId: serviceId ?? "",
    );

    for (int i = 0; i < (getServiceWiseProviderModel?.data?.length ?? 0); i++) {
      isProviderSaved.add(getServiceWiseProviderModel?.data?[i].isFavorite ?? false);
    }

    log("Provider is Saved :: $isProviderSaved");

    super.onInit();
  }

  onProviderSaved({required String customerId, required String providerId}) async {
    await homeScreenController.saveProviderByCustomerApiCall(
      customerId: customerId,
      providerId: providerId,
    );

    if (homeScreenController.saveProviderByCustomerModel?.status == true) {
      if (homeScreenController.saveProviderByCustomerModel?.providerIsFavorite == true) {
        Utils.showToast(Get.context!, "Provider saved successfully");

        int? index = homeScreenController.getTopRatedProviderModel?.data?.indexWhere((element) => element.id == providerId);
        if (index != null) {
          isProviderSaved[index] = true;
        }
      } else {
        int? index = homeScreenController.getTopRatedProviderModel?.data?.indexWhere((element) => element.id == providerId);
        if (index != null) {
          isProviderSaved[index] = false;
        }
      }
    } else {
      Utils.showToast(Get.context!, homeScreenController.saveProviderByCustomerModel?.message ?? "");
    }

    update([Constant.idCategoryProviderSaved]);
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null) {
        serviceName = args[0];
        serviceId = args[1];
      }

      log("Service Name :: $serviceName");
      log("Service Id :: $serviceId");
    }
  }

  /// =================== API Calling =================== ///

  GetServiceWiseProviderModel? getServiceWiseProviderModel;
  bool isLoading = false;

  getServiceWiseProviderApiCall({required String customerId, required String serviceId}) async {
    try {
      isLoading = true;
      update([Constant.idGetServiceWiseProvider]);

      final queryParameters = {
        "customerId": customerId,
        "serviceId": serviceId,
      };

      log("Get Service Wise Provider Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getServiceWiseProvider + queryString);
      log("Get Service Wise Provider Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Service Wise Provider Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Service Wise Provider Status Code :: ${response.statusCode}");
      log("Get Service Wise Provider Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getServiceWiseProviderModel = GetServiceWiseProviderModel.fromJson(jsonResponse);
      }

      log("Get Service Wise Provider Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Service Wise Provider Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetServiceWiseProvider]);
    }
  }
}
