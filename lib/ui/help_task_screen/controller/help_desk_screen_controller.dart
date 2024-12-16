import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/help_task_screen/model/raise_complain_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class HelpDeskScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();

  int selectedType = 0;
  List type = ["Complain", "Suggestion"];
  final ImagePicker imagePicker = ImagePicker();
  XFile? image;
  File? selectImageFile;

  TextEditingController suggestionController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  onPickImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectImageFile = File(image!.path);
    }
    update([Constant.idComplainImage]);
  }

  onSelectType(int index) {
    selectedType = index;
    update([Constant.idSelectType]);
  }

  onSubmitClick(BuildContext context) async {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      await raiseComplainApiCall(
        customerId: Constant.storage.read("customerId"),
        contact: contactController.text,
        details: suggestionController.text,
        image: selectImageFile?.path ?? "",
        type: selectedType == 0 ? "1" : "2",
      );

      Utils.showToast(Get.context!, raiseComplainModel?.message ?? "");

      if (raiseComplainModel?.status == true) {
        Get.back();
      }
    }
  }

  /// =================== API Calling =================== ///

  RaiseComplainModel? raiseComplainModel;
  bool isLoading = false;

  raiseComplainApiCall({
    required String customerId,
    required String details,
    required String contact,
    required String type,
    required String image,
  }) async {
    try {
      isLoading = true;
      update([Constant.idRaiseComplain]);

      var uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.raiseComplain);
      var request = http.MultipartRequest("POST", uri);
      log("Raise Complain URL :: $uri");

      if (image.isNotEmpty) {
        var addImage = await http.MultipartFile.fromPath("image", image);
        request.files.add(addImage);
        log("Raise Complain addImage :: $addImage");
        log("Raise Complain Image :: $image");
      }

      request.headers.addAll({"key": ApiConstant.SECRET_KEY});

      Map<String, String> requestBody = <String, String>{
        "customerId": customerId,
        "details": details,
        "contact": contact,
        "type": type,
      };

      log("Raise Complain Body :: $requestBody");

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      log("Raise Complain Status Code :: ${res.statusCode}");
      log("Raise Complain Response :: ${res.body}");

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        raiseComplainModel = RaiseComplainModel.fromJson(jsonResponse);
        return RaiseComplainModel.fromJson(jsonDecode(res.body));
      }

      log("Raise Complain Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error Call Raise Complain Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idRaiseComplain]);
    }
  }
}
