import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/booking_screen/model/get_appointment_time_model.dart';
import 'package:handy/ui/re_schedule_screen/model/re_schedule_appointment_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ReScheduleController extends GetxController {
  dynamic args = Get.arguments;

  String? providerProfileImage;
  String? providerName;
  String? serviceName;
  String? serviceProviderFee;
  String? providerAvgRating;
  String? date;
  String? time;
  String? providerId;
  Color? color;
  Color? textColor;
  String? appointmentId;

  DateTime? parsedDate;
  DateTime selectedDate = DateTime.now();
  late String? formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate ?? DateTime.now());
  String? slotsString;
  List<String> morningSlots = [];
  List<String> afternoonSlots = [];
  List<String> selectedSlotsList = [];
  List<String> bookedSlot = [];
  String? serviceStartTime;
  String? serviceBreakStartTime;
  String? serviceBreakEndTime;
  String? serviceEndTime;
  bool isFirstTap = false;
  bool hasMorningSlots = true;

  @override
  void onInit() async {
    await getDataFromArgs();

    parsedDate = DateFormat("yyyy-MM-dd").parse(date ?? "");
    formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate ?? DateTime.now());

    await getAppointmentTimeApiCall(
      providerId: providerId ?? "",
      date: date ?? "",
    );

    onGetSlotsList();
    onBookedSlot();

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
          args[10] != null) {
        providerProfileImage = args[0];
        providerName = args[1];
        serviceName = args[2];
        serviceProviderFee = args[3];
        providerAvgRating = args[4];
        date = args[5];
        time = args[6];
        providerId = args[7];
        color = args[8];
        textColor = args[9];
        appointmentId = args[10];
      }

      log("Provider Profile Image :: $providerProfileImage");
      log("Provider Name :: $providerName");
      log("Service Name :: $serviceName");
      log("Service Provider Fee :: $serviceProviderFee");
      log("Provider Avg Rating :: $providerAvgRating");
      log("Date :: $date");
      log("Time :: $time");
      log("Provider Id :: $providerId");
      log("Color :: $color");
      log("Text Color :: $textColor");
      log("Appointment ID :: $appointmentId");
    }
  }

  /// =================== Select Slot`s =================== ///
  onGetSlotsList() {
    morningSlots.clear();
    afternoonSlots.clear();

    for (var i = 0; i < (getAppointmentTimeModel?.allSlots?.morning?.length ?? 0); i++) {
      morningSlots.add(getAppointmentTimeModel?.allSlots?.morning?[i] ?? "");
    }

    for (var i = 0; i < (getAppointmentTimeModel?.allSlots?.evening?.length ?? 0); i++) {
      afternoonSlots.add(getAppointmentTimeModel?.allSlots?.evening?[i] ?? "");
    }

    serviceStartTime = morningSlots.first;
    serviceBreakStartTime = morningSlots.last;

    afternoonSlots = afternoonSlots.sublist(1);
    serviceEndTime = afternoonSlots.last;
    serviceBreakEndTime = afternoonSlots.first;

    log("Morning Slot :: $morningSlots");
    log("Afternoon Slot :: $afternoonSlots");

    update([Constant.idUpdateSlots, Constant.idGetAppointmentTime]);
  }

  void selectSlot(String slot) {
    selectedSlotsList.clear();

    selectedSlotsList.add(slot);
    time = selectedSlotsList.first;

    log("Selected Slot List :: $selectedSlotsList");
    log("Selected Time :: $time");
    update([Constant.idUpdateSlots, Constant.idGetAppointmentTime]);
  }

  List<DateTime> getDisabledDates() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];

    for (int i = 0; i < currentDate.day - 1; i++) {
      disabledDates.add(currentDate.subtract(Duration(days: i + 1)));
    }

    return disabledDates;
  }

  onBookedSlot() {
    bookedSlot = getAppointmentTimeModel?.busySlots ?? [];
    log("Booked Slot :: $bookedSlot");

    if (bookedSlot.contains(time)) {
      bookedSlot.remove(time);

      selectedSlotsList.add(time ?? "");
      log("Booked Slot remove :: $bookedSlot");
      log("Then SelectedSlot List :: $selectedSlotsList");
    }
  }

  onReScheduleClick() async {
    await reScheduleAppointmentApiCall(
      customerId: Constant.storage.read("customerId"),
      appointmentId: appointmentId ?? "",
      date: date ?? "",
      time: time ?? "",
    );

    if (reScheduleAppointmentModel?.status == true) {
      Utils.showToast(Get.context!, reScheduleAppointmentModel?.message ?? "");
      Get.back();
    } else {
      Utils.showToast(Get.context!, reScheduleAppointmentModel?.message ?? "");
    }
  }

  /// =================== API Calling =================== ///

  GetAppointmentTimeModel? getAppointmentTimeModel;
  ReScheduleAppointmentModel? reScheduleAppointmentModel;
  bool isLoading = false;
  bool isLoading1 = false;

  getAppointmentTimeApiCall({required String providerId, required String date}) async {
    try {
      isLoading = true;
      update([Constant.idGetAppointmentTime]);

      final queryParameters = {
        "providerId": providerId,
        "date": date,
      };

      log("Get Appointment Time Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getAppointmentTimeModel + queryString);
      log("Get Appointment Time Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Appointment Time Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Appointment Time Status Code :: ${response.statusCode}");
      log("Get Appointment Time Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getAppointmentTimeModel = GetAppointmentTimeModel.fromJson(jsonResponse);
      }

      log("Get Appointment Time Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Appointment Time Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetAppointmentTime]);
    }
  }

  reScheduleAppointmentApiCall({
    required String customerId,
    required String appointmentId,
    required String date,
    required String time,
  }) async {
    try {
      isLoading1 = true;
      update([Constant.idReScheduleAppointment]);

      final queryParameters = {
        "customerId": customerId,
        "appointmentId": appointmentId,
        "date": date,
        "time": time,
      };

      log("Re Schedule Appointment Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.reScheduleAppointment + queryString);
      log("Re Schedule Appointment Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Re Schedule Appointment Headers :: $headers");

      final response = await http.patch(url, headers: headers);

      log("Re Schedule Appointment Status Code :: ${response.statusCode}");
      log("Re Schedule Appointment Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        reScheduleAppointmentModel = ReScheduleAppointmentModel.fromJson(jsonResponse);
      }

      log("Re Schedule Appointment Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Re Schedule Appointment Api :: $e");
    } finally {
      isLoading1 = false;
      update([Constant.idReScheduleAppointment]);
    }
  }
}
