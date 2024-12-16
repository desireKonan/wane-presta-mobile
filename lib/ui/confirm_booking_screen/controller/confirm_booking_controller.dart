import 'dart:convert';
import 'dart:developer';

import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/apply_coupon_screen/model/get_coupon_amount_model.dart';
import 'package:handy/ui/apply_coupon_screen/model/get_coupon_model.dart';
import 'package:handy/ui/confirm_booking_screen/model/create_booking_by_customer_model.dart';
import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConfirmBookingController extends GetxController {
  dynamic args = Get.arguments;

  Color? color;
  Color? textColor;
  String? providerId;
  String? profileImage;
  String? name;
  String? services;
  String? price;
  String? avgRating;
  String? formattedDate;
  String? selectedSlotsList;
  String? serviceController;
  List? imageFileList;
  String? serviceId;
  num? taxRate;
  List<num> priceList = [];
  num? finalAmount;
  num? finalAmountBooking;

  int selectAmountIndex = 0;
  int applyCoupon = -1;
  String? couponCode;

  String amount = '50';
  String currency = '50';
  num? finalAmountAfterCoupon;

  List directAmount = ["50", "100", "150", "200", "250", "300", "350"];
  TextEditingController currencyController = TextEditingController();
  HistoryScreenController historyScreenController = Get.find<HistoryScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();
    amount = directAmount[0];
    currency = directAmount[0];
    currencyController.text = amount;

    await getCouponApiCall(
      customerId: Constant.storage.read('customerId'),
      type: "2",
      amount: amount,
    );

    await historyScreenController.getWalletHistoryApiCall(
      customerId: Constant.storage.read('customerId'),
      month: DateFormat('yyyy-MM').format(DateTime.now()),
      start: "1",
      limit: "20",
    );

    if (historyScreenController.getWalletHistoryModel?.status == true) {
      Constant.storage.write("walletAmount", historyScreenController.getWalletHistoryModel?.total?.toStringAsFixed(2));
      log("Wallet Amount :: ${Constant.storage.read("walletAmount")}");
    }

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null ||
          args[1] != null ||
          args[2] != null ||
          args[3] != null ||
          args[4] != null ||
          args[5] != null ||
          args[6] != null ||
          args[7] != null ||
          args[8] != null ||
          args[9] != null ||
          args[10] != null ||
          args[11] != null ||
          args[12] != null ||
          args[13] != null ||
          args[14] != null ||
          args[15] != null) {
        color = args[0];
        textColor = args[1];
        providerId = args[2];
        profileImage = args[3];
        name = args[4];
        services = args[5];
        price = args[6];
        avgRating = args[7];
        formattedDate = args[8];
        selectedSlotsList = args[9];
        serviceController = args[10];
        imageFileList = args[11];
        serviceId = args[12];
        taxRate = args[13];
        priceList = args[14];
        finalAmount = args[15];
        finalAmountBooking = args[15];
      }

      log("Color :: $color");
      log("Text Color :: $textColor");
      log("Provider Id :: $providerId");
      log("Profile Image :: $profileImage");
      log("Name :: $name");
      log("Services :: $services");
      log("Price :: $price");
      log("Avg Rating :: $avgRating");
      log("Selected Date :: $formattedDate");
      log("Selected Slots :: $selectedSlotsList");
      log("Service Controller :: $serviceController");
      log("Image File List :: $imageFileList");
      log("Service Id Confirm Booking :: $serviceId");
      log("Tax Rate Confirm Booking :: $taxRate");
      log("Price List Confirm Booking :: $priceList");
      log("Final Amount Confirm Booking :: $finalAmount");
      log("Final Amount Confirm Booking :: $finalAmountBooking");
    }
  }

  onSelectAmount(int index) async {
    selectAmountIndex = index;
    amount = directAmount[index];
    currency = directAmount[index];
    currencyController.text = amount;

    await getCouponApiCall(
      customerId: Constant.storage.read('customerId'),
      type: "2",
      amount: amount,
    );

    applyCoupon = -1;
    couponCode = '';
    Constant.storage.write('couponId', "");

    log("Currency is :: $currency");
    log("Amount is :: $amount");
    log("Currency Controller :: ${currencyController.text}");

    update([Constant.idSelectAmount]);
  }

  void printLatestValue({required String text}) async {
    amount = text;
    currencyController.text = amount;

    log("Amount is :: $amount");
    log("Currency Controller :: ${currencyController.text}");

    if (text.length != 1 || text.isNotEmpty == true) {
      await getCouponApiCall(
        customerId: Constant.storage.read('customerId'),
        type: "2",
        amount: amount,
      );

      applyCoupon = -1;
      couponCode = '';
      Constant.storage.write('couponId', "");
    }
  }

  onMoneyOffer(int index) {
    if (applyCoupon == index) {
      applyCoupon = -1;
      couponCode = '';
      Constant.storage.write('couponId', "");
    } else {
      applyCoupon = index;

      couponCode = getCouponModel?.data?[index].code ?? '';
      Constant.storage.write('couponId', getCouponModel?.data?[index].id);

      onApplyCouponClick();

      log("Coupon Id :: ${Constant.storage.read("couponId")}");
    }
    update([Constant.idGetCoupon, Constant.idApplyCoupon, Constant.idMoneyOffer]);
  }

  onApplyCouponClick() async {
    priceList.add(0);
    priceList.add(0);

    await getCouponAmountApiCall(
      customerId: Constant.storage.read('customerId'),
      type: "2",
      amount: amount,
      couponId: couponCode ?? "",
    );

    if (getCouponAmountModel?.status == true) {
      finalAmountAfterCoupon = (int.parse(amount) - (getCouponAmountModel?.data ?? 0));

      priceList.clear();

      priceList.add(int.parse(amount));
      priceList.add(getCouponAmountModel?.data ?? 0);
      log("-------------- $priceList");

      log("Before Amount :: $amount");
      log("Final Amount After Coupon :: $finalAmountAfterCoupon");

      update([Constant.idMoneyOffer]);
    } else {
      Utils.showToast(Get.context!, getCouponAmountModel?.message ?? "");
    }
  }

  onRechargeClick() {
    if (applyCoupon == -1) {
      Get.toNamed(
        AppRoutes.payment,
        arguments: [
          int.parse(amount),
          Constant.storage.read("couponId"),
        ],
      );
    } else {
      Get.toNamed(
        AppRoutes.payment,
        arguments: [
          finalAmountAfterCoupon,
          Constant.storage.read("couponId"),
        ],
      );
    }
  }

  onPayNowClick() async {
    await createBookingByCustomerApiCall(
      couponId: Constant.storage.read("isApplyCoupon") == true ? Constant.storage.read("couponId") : "",
      customerId: Constant.storage.read('customerId'),
      serviceId: serviceId ?? "",
      providerId: providerId ?? "",
      date: formattedDate ?? "",
      time: selectedSlotsList ?? "",
      finalAmount: finalAmount.toString(),
      serviceFee: price.toString(),
      serviceInfo: serviceController ?? "",
      image: imageFileList ?? [],
    );

    if (createBookingByCustomerModel?.status == true) {
      Utils.showToast(Get.context!, createBookingByCustomerModel?.message ?? "");

      Constant.storage.write("couponId", "");
      Constant.storage.write("isApplyCoupon", false);

      Get.offAllNamed(
        AppRoutes.confirmAppointment,
        arguments: [
          color,
          textColor,
          profileImage,
          name,
          services,
          price,
          avgRating,
          formattedDate,
          selectedSlotsList,
        ],
      );
    } else {
      Utils.showToast(Get.context!, createBookingByCustomerModel?.message ?? "");
    }
  }

  /// =================== API Calling =================== ///

  CreateBookingByCustomerModel? createBookingByCustomerModel;
  GetCouponModel? getCouponModel;
  GetCouponAmountModel? getCouponAmountModel;
  bool isLoading = false;
  bool isLoading1 = false;

  createBookingByCustomerApiCall({
    required String couponId,
    required String customerId,
    required String serviceId,
    required String providerId,
    required String date,
    required String time,
    required String finalAmount,
    required String serviceFee,
    required String serviceInfo,
    required List image,
  }) async {
    try {
      isLoading = true;
      update([Constant.idCreateBookingByCustomer]);

      var uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.createBookingByCustomer);
      var request = http.MultipartRequest("POST", uri);
      log("Create Booking By Customer URL :: $uri");

      if (image.isNotEmpty) {
        for (var file in image) {
          var addPhotoAlbum = await http.MultipartFile.fromPath("image", file.path);
          request.files.add(addPhotoAlbum);
          log("Create Booking By Customer addPhotoAlbum :: $addPhotoAlbum");
          log("Create Booking By Customer Image :: $image");
        }
      }

      request.headers.addAll({"key": ApiConstant.SECRET_KEY});

      Map<String, String> requestBody = <String, String>{
        "couponId": couponId,
        "customerId": customerId,
        "serviceId": serviceId,
        "providerId": providerId,
        "date": date,
        "time": time,
        "finalAmount": finalAmount,
        "serviceFee": serviceFee,
        "serviceInfo": serviceInfo,
      };

      log("Create Booking By Customer Body :: $requestBody");

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      log("Create Booking By Customer Status Code :: ${res.statusCode}");
      log("Create Booking By Customer Response :: ${res.body}");

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        createBookingByCustomerModel = CreateBookingByCustomerModel.fromJson(jsonResponse);
        return CreateBookingByCustomerModel.fromJson(jsonDecode(res.body));
      }

      log("Create Booking By Customer Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error Call Create Booking By Customer Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idCreateBookingByCustomer]);
    }
  }

  getCouponApiCall({required String customerId, required String type, required String amount}) async {
    try {
      isLoading = true;
      update([Constant.idGetCoupon, Constant.idApplyCoupon, Constant.idMoneyOffer]);

      final queryParameters = {
        "customerId": customerId,
        "type": type,
        "amount": amount,
      };

      log("Get Coupon Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getCoupon + queryString);
      log("Get Coupon Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Coupon Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Coupon Status Code :: ${response.statusCode}");
      log("Get Coupon Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getCouponModel = GetCouponModel.fromJson(jsonResponse);
      }

      log("Get Coupon Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Coupon Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetCoupon, Constant.idApplyCoupon, Constant.idMoneyOffer]);
    }
  }

  getCouponAmountApiCall({
    required String customerId,
    required String type,
    required String amount,
    required String couponId,
  }) async {
    try {
      isLoading1 = true;
      update([Constant.idGetCouponAmount]);

      final queryParameters = {
        "customerId": customerId,
        "type": type,
        "amount": amount,
        "couponId": couponId,
      };

      log("Get Coupon Amount Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getCouponAmount + queryString);
      log("Get Coupon Amount Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Coupon Amount Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Coupon Amount Status Code :: ${response.statusCode}");
      log("Get Coupon Amount Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getCouponAmountModel = GetCouponAmountModel.fromJson(jsonResponse);
      }

      log("Get Coupon Amount Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Coupon Amount Api :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idGetCouponAmount]);
    }
  }
}
