import 'dart:convert';
import 'dart:developer';

import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/services/location_service/location_service.dart';
import 'package:handy/ui/search_screen/model/get_filter_wise_provider_model.dart';
import 'package:handy/ui/search_screen/model/search_by_customer_model.dart';
import 'package:handy/ui/search_screen/widget/search_screen_widget.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class SearchScreenController extends GetxController {
  List getAllService = [];
  List getAllProvider = [];
  List getAllSearchProvider = [];

  String? genderName;
  int genderSelect = -1;

  String? finalRating;
  int ratingSelect = -1;

  String? serviceName;
  int serviceSelect = -1;

  String? locationName;
  int locationSelect = -1;

  List ratings = ["5.0", "4.0", "3.0", "2.0", "1.0"];
  List locations = [(EnumLocale.txtNearbyMe.name.tr), "5km", "10km", "15km"];
  List locationsName = ["nearby", "5", "10", "15"];

  TextEditingController searchController = TextEditingController();

  onServiceSelect(int index) {
    if (serviceSelect == index) {
      serviceSelect = -1;
      serviceName = "";
    } else {
      serviceSelect = index;
      serviceName = getAllService[index];
    }
    log("Category Name :: $serviceName");
    update([Constant.idSelectCategories, Constant.idApplyFilter]);
  }

  onGenderSelect(int index) {
    if (genderSelect == index) {
      genderSelect = -1;
      genderName = "";
    } else {
      genderSelect = index;
      if (genderList[index] == "Female") {
        genderName = "female";
      } else if (genderList[index] == "Male") {
        genderName = "male";
      } else {
        genderName = "both";
      }
    }
    log("Gender Name :: $genderName");
    update([Constant.idGenderSelect, Constant.idApplyFilter]);
  }

  onRatingSelect(int index) {
    if (ratingSelect == index) {
      ratingSelect = -1;
      finalRating = "0.0";
    } else {
      ratingSelect = index;
      finalRating = ratings[index];
    }
    log("Ratings :: $finalRating");
    update([Constant.idRatingSelect, Constant.idApplyFilter]);
  }

  onLocationSelect(int index) {
    if (locationSelect == index) {
      locationSelect = -1;
      locationName = "";
    } else {
      locationSelect = index;
      locationName = locationsName[index];
    }

    update([Constant.idSelectLocation, Constant.idApplyFilter]);
  }

  void searchBy({required String text}) async {
    log("Text is :: $text");

    if (text.isEmpty) {
      log("getAllProvider :: $getAllProvider");

      getAllSearchProvider = getAllProvider;
    } else {
      await searchByCustomerApiCall(
        customerId: Constant.storage.read("customerId"),
        searchString: text,
      );
    }
  }

  onApplyFilter() async {
    try {
      isLoading = true;
      update([Constant.idGetFilterWiseProvider]);

      Get.back();

      await permissions();
      await Permission.locationAlways.request();

      await getFilterWiseProviderApiCall(
        customerId: Constant.storage.read("customerId"),
        gender: genderName ?? "",
        rating: double.parse(finalRating ?? "0.0"),
        service: serviceName ?? "",
        distance: locationName ?? "",
        latitude: latitude.toString(),
        longitude: longitude.toString(),
      );
    } catch (e) {
      log("Error in apply filter :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetFilterWiseProvider]);
    }
  }

  onBackToFilter() async {
    Get.back();

    await getFilterWiseProviderApiCall(
      customerId: Constant.storage.read("customerId"),
      gender: genderName ?? "",
      rating: double.parse(finalRating ?? "0.0"),
      service: serviceName ?? "",
      distance: locationName ?? "",
      latitude: latitude.toString(),
      longitude: longitude.toString(),
    );
  }

  /// =================== API Calling =================== ///

  SearchByCustomerModel? searchByCustomerModel;
  GetFilterWiseProviderModel? getFilterWiseProviderModel;
  bool isLoading = false;

  searchByCustomerApiCall({required String customerId, required String searchString}) async {
    try {
      isLoading = true;
      update([Constant.idSearchByCustomer, Constant.idGetFilterWiseProvider]);

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Search By Customer Headers :: $headers");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.searchByCustomer);
      var request = http.Request('GET', url);

      log("Search By Customer Url :: $request");

      request.body = json.encode({
        "customerId": customerId,
        "searchString": searchString,
      });

      log("Search By Customer Body :: ${request.body}");

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      log("Search By Customer Status Code :: ${response.statusCode}");

      if (response.statusCode == 200) {
        final String bookingCategory = await response.stream.bytesToString();

        log("Search By Customer Response :: $bookingCategory");
        searchByCustomerModel = SearchByCustomerModel.fromJson(json.decode(bookingCategory));

        getAllSearchProvider.clear();

        for (int i = 0; i < (searchByCustomerModel?.data?.length ?? 0); i++) {
          getAllSearchProvider.add(searchByCustomerModel?.data?[i] ?? []);
        }

        log("getAllSearchProvider :: $getAllSearchProvider");
      }
      return searchByCustomerModel;
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Search By Customer Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idSearchByCustomer, Constant.idGetFilterWiseProvider]);
    }
  }

  getFilterWiseProviderApiCall({
    required String customerId,
    required String gender,
    required double rating,
    required String service,
    required String distance,
    required String latitude,
    required String longitude,
  }) async {
    try {
      isLoading = true;
      update([Constant.idGetFilterWiseProvider]);

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Filter Wise Provider Headers :: $headers");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getFilterWiseProvider);
      var request = http.Request('GET', url);

      log("Get Filter Wise Provider Url :: $request");

      request.body = json.encode({
        "customerId": customerId,
        "gender": gender,
        "rating": rating,
        "service": service,
        "distance": distance,
        "latitude": latitude,
        "longitude": longitude,
      });

      log("Get Filter Wise Provider Body :: ${request.body}");

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      log("Get Filter Wise Provider Status Code :: ${response.statusCode}");

      if (response.statusCode == 200) {
        final String bookingCategory = await response.stream.bytesToString();

        log("Get Filter Wise Provider Response :: $bookingCategory");
        getFilterWiseProviderModel = GetFilterWiseProviderModel.fromJson(json.decode(bookingCategory));

        getAllSearchProvider.clear();

        for (int i = 0; i < (getFilterWiseProviderModel?.data?.length ?? 0); i++) {
          getAllSearchProvider.add(getFilterWiseProviderModel?.data?[i] ?? []);
        }

        log("getAllSearchProvider :: $getAllSearchProvider");
      }
      return getFilterWiseProviderModel;
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Filter Wise Provider Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetFilterWiseProvider]);
    }
  }
}
