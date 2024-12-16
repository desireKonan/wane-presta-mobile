import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/home_screen/model/get_banner_model.dart';
import 'package:handy/ui/home_screen/model/get_service_model.dart';
import 'package:handy/ui/home_screen/model/get_top_rated_provider_model.dart';
import 'package:handy/ui/home_screen/model/get_upcoming_appointment_model.dart';
import 'package:handy/ui/home_screen/model/save_provider_by_customer_model.dart';
import 'package:handy/ui/search_screen/controller/search_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/utils.dart';

class HomeScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController? tabController;
  PageController pageController = PageController();

  List<bool> isProviderSaved = [];

  List? bannersImages;
  List? type;

  int selectedService = -1;
  String? serviceId;
  String? servicePrice;
  String? serviceName;

  SearchScreenController searchScreenController = Get.put(SearchScreenController());

  @override
  void onInit() async {
    log("Enter In Home screen Controller");
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);

    await getServiceApiCall();
    await getBannerApiCall();
    await getTopRatedProviderApiCall();
    await getUpcomingAppointmentApiCall();

    for (int i = 0; i < (getTopRatedProviderModel?.data?.length ?? 0); i++) {
      isProviderSaved.add(getTopRatedProviderModel?.data?[i].isFavorite ?? false);
    }

    log("Provider is Saved :: $isProviderSaved");

    super.onInit();
  }

  onRefreshData() async {
    await getServiceApiCall();
    await getBannerApiCall();
    await getTopRatedProviderApiCall();
    await getUpcomingAppointmentApiCall();

    for (int i = 0; i < (getTopRatedProviderModel?.data?.length ?? 0); i++) {
      isProviderSaved.add(getTopRatedProviderModel?.data?[i].isFavorite ?? false);
    }

    log("Provider is Saved :: $isProviderSaved");
  }

  onProviderSaved({required String customerId, required String providerId}) async {
    await saveProviderByCustomerApiCall(
      customerId: customerId,
      providerId: providerId,
    );

    if (saveProviderByCustomerModel?.status == true) {
      if (saveProviderByCustomerModel?.providerIsFavorite == true) {
        Utils.showToast(Get.context!, "Provider saved successfully");

        int? index = getTopRatedProviderModel?.data?.indexWhere((element) => element.id == providerId);
        if (index != null) {
          isProviderSaved[index] = true;
        }
      } else {
        int? index = getTopRatedProviderModel?.data?.indexWhere((element) => element.id == providerId);
        if (index != null) {
          isProviderSaved[index] = false;
        }
      }
    } else {
      Utils.showToast(Get.context!, saveProviderByCustomerModel?.message ?? "");
    }

    update([Constant.idServiceSaved]);
  }

  Widget imageView(String image) {
    return CachedNetworkImage(
      imageUrl: "${ApiConstant.BASE_URL}$image",
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return Image.asset(AppAsset.icPlaceholderImage).paddingAll(40);
      },
      errorWidget: (context, url, error) {
        return Image.asset(AppAsset.icPlaceholderImage).paddingAll(40);
      },
    );
  }

  onSelectService(int index) {
    if (selectedService == index) {
      selectedService = -1;
    } else {
      selectedService = index;
    }
    update([Constant.idServiceSelected]);
  }

  /// =================== API Calling =================== ///

  GetServiceModel? getServiceModel;
  GetBannerModel? getBannerModel;
  GetTopRatedProviderModel? getTopRatedProviderModel;
  SaveProviderByCustomerModel? saveProviderByCustomerModel;
  GetUpcomingAppointmentModel? getUpcomingAppointmentModel;
  bool isLoading = false;

  getServiceApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedProvider, Constant.idGetUpcomingAppointment]);

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getService);
      log("Get Service Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Service Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Service Status Code :: ${response.statusCode}");
      log("Get Service Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getServiceModel = GetServiceModel.fromJson(jsonResponse);

        for (int i = 0; i < (getServiceModel?.data?.length ?? 0); i++) {
          searchScreenController.getAllService.add(getServiceModel?.data?[i].name ?? "");
        }
        log("Get All Category :: ${searchScreenController.getAllService}");
      }

      log("Get Service Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Service Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedProvider, Constant.idGetUpcomingAppointment]);
    }
  }

  getBannerApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedProvider, Constant.idGetUpcomingAppointment]);

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getBanner);
      log("Get Banner Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Banner Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Banner Status Code :: ${response.statusCode}");
      log("Get Banner Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getBannerModel = GetBannerModel.fromJson(jsonResponse);
      }

      log("Get Banner Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Banner Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedProvider, Constant.idGetUpcomingAppointment]);
    }
  }

  getTopRatedProviderApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedProvider, Constant.idGetUpcomingAppointment]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId"),
      };

      log("Get Top Rated Provider Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getTopRatedProvider + queryString);
      log("Get Top Rated Provider Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Top Rated Provider Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Top Rated Provider Status Code :: ${response.statusCode}");
      log("Get Top Rated Provider Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getTopRatedProviderModel = GetTopRatedProviderModel.fromJson(jsonResponse);

        searchScreenController.getAllProvider.clear();

        searchScreenController.getAllProvider.addAll(getTopRatedProviderModel?.data ?? []);
        searchScreenController.getAllSearchProvider.addAll(getTopRatedProviderModel?.data ?? []);

        log("Get All Provider :: ${searchScreenController.getAllProvider}");
      }

      log("Get Top Rated Provider Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Top Rated Provider Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedProvider, Constant.idGetUpcomingAppointment]);
    }
  }

  saveProviderByCustomerApiCall({required String customerId, required String providerId}) async {
    try {
      isLoading = true;
      update([Constant.idSaveProviderByCustomer]);

      final queryParameters = {
        "customerId": customerId,
        "providerId": providerId,
      };

      log("Save Provider By Customer Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.saveProviderByCustomer + queryString);
      log("Save Provider By Customer Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Save Provider By Customer Headers :: $headers");

      var response = await http.post(url, headers: headers);

      log("Save Provider By Customer Status Code :: ${response.statusCode}");
      log("Save Provider By Customer Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        saveProviderByCustomerModel = SaveProviderByCustomerModel.fromJson(jsonResponse);
      }

      log("Save Provider By Customer Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Save Provider By Customer Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idSaveProviderByCustomer]);
    }
  }

  getUpcomingAppointmentApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedProvider, Constant.idGetUpcomingAppointment]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId"),
      };

      log("Get Upcoming Appointment Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getUpcomingAppointment + queryString);
      log("Get Upcoming Appointment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Upcoming Appointment Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Upcoming Appointment Status Code :: ${response.statusCode}");
      log("Get Upcoming Appointment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getUpcomingAppointmentModel = GetUpcomingAppointmentModel.fromJson(jsonResponse);
      }

      log("Get Upcoming Appointment Api Call Successful");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Upcoming Appointment Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetService, Constant.idGetBanner, Constant.idGetTopRatedProvider, Constant.idGetUpcomingAppointment]);
    }
  }
}
