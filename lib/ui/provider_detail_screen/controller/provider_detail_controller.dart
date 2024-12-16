import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/provider_detail_screen/model/get_provider_info_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class ProviderDetailController extends GetxController with GetSingleTickerProviderStateMixin {
  dynamic args = Get.arguments;
  Color? color;
  Color? textColor;
  String? providerId;
  String? serviceId;
  String? servicePrice;
  String? serviceName;

  bool isSaved = false;
  late TabController? tabController;

  @override
  void onInit() async {
    tabController = TabController(initialIndex: 0, length: 6, vsync: this);

    await getDataFromArgs();
    await getProviderInfoApiCall(
      providerId: providerId ?? "",
      customerId: Constant.storage.read('customerId'),
    );
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null || args[3] != null || args[4] != null || args[5] != null) {
        color = args[0];
        textColor = args[1];
        providerId = args[2];
        serviceId = args[3];
        servicePrice = args[4];
        serviceName = args[5];
      }

      log("Color :: $color");
      log("Text Color :: $textColor");
      log("Provider ID :: $providerId");
      log("Service ID Provider Detail :: $serviceId");
      log("Service Price Provider Detail :: $servicePrice");
      log("Service Name Provider Detail :: $serviceName");
    }
  }

  onBookNowClick() {
    Get.toNamed(
      AppRoutes.booking,
      arguments: [
        color,
        textColor,
        providerId,
        getProviderInfoModel?.providerInfo?.profileImage,
        getProviderInfoModel?.providerInfo?.name,
        serviceName,
        servicePrice,
        getProviderInfoModel?.providerInfo?.avgRating?.toStringAsFixed(1),
        serviceId,
        getProviderInfoModel?.providerInfo?.taxRate,
      ],
    );
  }

  /// =================== API Calling =================== ///

  GetProviderInfoModel? getProviderInfoModel;
  bool isLoading = false;

  getProviderInfoApiCall({required String providerId, required String customerId}) async {
    try {
      isLoading = true;
      update([Constant.idGetProviderInfo]);

      final queryParameters = {
        "providerId": providerId,
        "customerId": customerId,
      };

      log("Get Provider Info Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getProviderInfo + queryString);
      log("Get Provider Info Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Provider Info Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Provider Info Status Code :: ${response.statusCode}");
      log("Get Provider Info Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getProviderInfoModel = GetProviderInfoModel.fromJson(jsonResponse);
      }

      log("Get Provider Info Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Provider Info Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetProviderInfo]);
    }
  }
}
