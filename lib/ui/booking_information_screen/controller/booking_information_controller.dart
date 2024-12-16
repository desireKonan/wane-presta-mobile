import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/booking_information_screen/model/get_appointment_info_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/utils.dart';

class BookingInformationController extends GetxController {
  dynamic args = Get.arguments;

  String? appointmentId;
  Color? color;
  Color? textColor;

  List priceList = [];
  num? finalAmount;

  @override
  void onInit() async {
    await getDataFromArgs();

    await getAppointmentInfoApiCall(
      customerId: Constant.storage.read('customerId'),
      appointmentId: appointmentId ?? "",
    );

    priceList.add(getAppointmentInfoModel?.data?.serviceProviderFee);
    priceList.add(getAppointmentInfoModel?.data?.taxAmount);

    getAppointmentInfoModel?.data?.discountAmount == 0 ? null : priceList.add(getAppointmentInfoModel?.data?.discountAmount ?? 0);

    finalAmount = (getAppointmentInfoModel?.data?.serviceProviderFee ?? 0) +
        (getAppointmentInfoModel?.data?.taxAmount ?? 0) +
        (getAppointmentInfoModel?.data?.discountAmount ?? 0);
    log("Final Amount Booking Info :: $finalAmount");

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null) {
        appointmentId = args[0];
        color = args[1];
        textColor = args[2];
      }

      log("Get Appointment Info Appointment ID :: $appointmentId");
    }
  }

  /// =================== API Calling =================== ///

  GetAppointmentInfoModel? getAppointmentInfoModel;
  bool isLoading = false;

  getAppointmentInfoApiCall({required String customerId, required String appointmentId}) async {
    try {
      isLoading = true;
      update([Constant.idGetAppointmentInfo]);

      final queryParameters = {
        "customerId": customerId,
        "appointmentId": appointmentId,
      };

      log("Get Appointment Info Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAppointmentInfo + queryString);
      log("Get Appointment Info Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Appointment Info Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Appointment Info Status Code :: ${response.statusCode}");
      log("Get Appointment Info Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAppointmentInfoModel = GetAppointmentInfoModel.fromJson(jsonResponse);
      }

      log("Get Appointment Info Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Appointment Info Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetAppointmentInfo]);
    }
  }
}
