import 'dart:convert';
import 'dart:developer';

import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/saved_provider_screen/model/get_all_save_provider_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class SavedProviderController extends GetxController {
  dynamic args = Get.arguments;
  bool? isBack;

  List<bool> isProviderSaved = [];

  HomeScreenController homeScreenController = Get.find<HomeScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();

    await getAllSaveProviderApiCall();

    isProviderSaved = List<bool>.filled(getAllSaveProviderModel?.data?.length ?? 0, false);
    for (int i = 0; i < (getAllSaveProviderModel?.data?.length ?? 0); i++) {
      isProviderSaved[i] = true;
    }

    log("Provider is Saved :: $isProviderSaved");
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        isBack = args[0];
      }
    }

    log("Is Back :: $isBack");
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

    update([Constant.idServiceSaved]);
  }

  /// =================== API Calling =================== ///

  GetAllSaveProviderModel? getAllSaveProviderModel;
  bool isLoading = false;

  getAllSaveProviderApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetAllSaveProvider]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId"),
      };

      log("Get All Save Provider Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAllSaveProvider + queryString);
      log("Get All Save Provider Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get All Save Provider Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get All Save Provider Status Code :: ${response.statusCode}");
      log("Get All Save Provider Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAllSaveProviderModel = GetAllSaveProviderModel.fromJson(jsonResponse);
      }

      log("Get All Save Provider Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get All Save Provider Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetAllSaveProvider]);
    }
  }
}
