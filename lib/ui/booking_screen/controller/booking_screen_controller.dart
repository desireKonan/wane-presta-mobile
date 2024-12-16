import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/booking_screen/model/get_appointment_time_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class BookingScreenController extends GetxController {
  dynamic args = Get.arguments;
  final formKey = GlobalKey<FormState>();

  String? formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime selectedDate = DateTime.now();

  String? slotsString;
  List<String> morningSlots = [];
  List<String> afternoonSlots = [];
  List<String> selectedSlotsList = [];
  String? serviceStartTime;
  String? serviceBreakStartTime;
  String? serviceBreakEndTime;
  String? serviceEndTime;
  bool isFirstTap = false;
  bool hasMorningSlots = true;

  Color? color;
  Color? textColor;
  String? providerId;
  String? profileImage;
  String? name;
  String? services;
  String? price;
  String? avgRating;
  String? serviceId;
  num? taxRate;

  List<num> priceList = [];
  num? finalAmount;

  /// for Select Multiple image
  final ImagePicker imagePicker = ImagePicker();
  List<File>? imageFileList = [];
  List<XFile>? selectedImages = [];

  TextEditingController serviceController = TextEditingController();

  @override
  void onInit() async {
    await getDataFromArgs();

    priceList.add(num.parse(price!));
    priceList.add(taxRate! * num.parse(price!) / 100);

    finalAmount = num.parse(price!) + taxRate! * num.parse(price!) / 100;

    log("Price List :: $priceList");
    log("Final Amount :: $finalAmount");

    await getAppointmentTimeApiCall(
      providerId: providerId ?? "",
      date: formattedDate ?? "",
    );

    onGetSlotsList();
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
          args[9] != null) {
        color = args[0];
        textColor = args[1];
        providerId = args[2];
        profileImage = args[3];
        name = args[4];
        services = args[5];
        price = args[6];
        avgRating = args[7];
        serviceId = args[8];
        taxRate = args[9];
      }

      log("Color :: $color");
      log("Text Color :: $textColor");
      log("Provider ID :: $providerId");
      log("Profile Image :: $profileImage");
      log("Name :: $name");
      log("Services :: $services");
      log("Price :: $price");
      log("Avg Rating :: $avgRating");
      log("Service ID booking screen :: $serviceId");
      log("Tax Rate booking screen :: $taxRate");
    }
  }

  onMultiplePickImage() async {
    selectedImages = await imagePicker.pickMultiImage();

    if (selectedImages!.isNotEmpty) {
      for (XFile images in selectedImages!) {
        imageFileList!.add(File(images.path));
      }
    }
    update([Constant.idPickImage]);
  }

  onRemoveImage(int index) {
    imageFileList!.removeAt(index);
    update([Constant.idRemoveImage, Constant.idPickImage]);
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

  onConfirmBookingClick(BuildContext context) {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate() && selectedSlotsList.isNotEmpty) {
      Get.toNamed(
        AppRoutes.confirmBooking,
        arguments: [
          color,
          textColor,
          providerId,
          profileImage,
          name,
          services,
          price,
          avgRating,
          formattedDate,
          selectedSlotsList.join(),
          serviceController.text,
          imageFileList,
          serviceId,
          taxRate,
          priceList,
          finalAmount,
        ],
      );
    } else {
      if (selectedSlotsList.isEmpty) {
        Utils.showToast(Get.context!, EnumLocale.toastSelectTime.name.tr);
      }
    }
  }

  /// =================== API Calling =================== ///

  GetAppointmentTimeModel? getAppointmentTimeModel;
  bool isLoading = false;

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
}
