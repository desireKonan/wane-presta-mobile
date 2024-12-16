import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/socket/socket_constants.dart';
import 'package:handy/socket/socket_manager.dart';
import 'package:handy/ui/personal_chat_screen/model/create_chat_image_model.dart';
import 'package:handy/ui/personal_chat_screen/model/get_call_enable_or_not_model.dart';
import 'package:handy/ui/personal_chat_screen/model/get_old_chat_model.dart';
import 'package:handy/ui/personal_chat_screen/model/get_provider_service_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PersonalChatController extends GetxController {
  dynamic args = Get.arguments;

  String? providerId;
  String? chatTopicId;
  String? providerName;
  String? providerImage;
  String? serviceName;

  final ImagePicker imagePicker = ImagePicker();
  XFile? image;
  File? selectImageFile;
  XFile? video;
  File? selectVideoFile;
  XFile? camera;
  File? selectCameraFile;
  String? finalThumbnail;
  String? tempPath;

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  TextEditingController chatController = TextEditingController();

  @override
  void onInit() async {
    await getDataFromArgs();

    SocketManager.setMessageList.clear();

    await getOldChatApiCall(
      senderId: Constant.storage.read("customerId"),
      receiverId: providerId ?? "",
      senderRole: "customer",
    );
    SocketManager.onScrollDown();

    await getProviderServiceApiCall(providerId: providerId ?? "");
    await getCallEnableOrNotApiCall(
      customerId: Constant.storage.read("customerId"),
      providerId: providerId ?? "",
    );

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null || args[3] != null || args[4] != null) {
        providerId = args[0];
        chatTopicId = args[1];
        providerName = args[2];
        providerImage = args[3];
        serviceName = args[4];
      }
      log("Provider ID :: $providerId");
      log("Chat Topic ID :: $chatTopicId");
      log("Provider Name :: $providerName");
      log("Provider Image :: $providerImage");
      log("Service Name :: $serviceName");
    }
  }

  sendMessage({required int messageType}) {
    DateTime now = DateTime.now();
    String date = DateFormat("M/dd/yyyy, hh:mm:ss a").format(now);

    if (messageType == 1) {
      Map<String, dynamic> messageMap = {
        'chatTopicId': chatTopicId,
        'senderId': Constant.storage.read("customerId"),
        'receiverId': providerId,
        'message': chatController.text.trim(),
        'messageType': messageType,
        'role': 'customer',
        'date': date,
        'image': "",
        'video': "",
      };

      SocketManager.emit(SocketConstants.message, messageMap);
    } else if (messageType == 2) {
      Map<String, dynamic> messageMap = {
        'chatTopicId': chatTopicId,
        'senderId': Constant.storage.read("customerId"),
        'receiverId': providerId,
        'message': "",
        'messageType': messageType,
        'role': 'customer',
        'date': date,
        'image': createChatImageModel?.chat?.image,
        'video': "",
      };
      SocketManager.emit(SocketConstants.message, messageMap);
    } else {
      Map<String, dynamic> messageMap = {
        'chatTopicId': chatTopicId,
        'senderId': Constant.storage.read("customerId"),
        'receiverId': providerId,
        'message': "",
        'messageType': messageType,
        'role': 'customer',
        'date': date,
        'image': createChatImageModel?.chat?.image,
        'video': createChatImageModel?.chat?.video,
      };
      SocketManager.emit(SocketConstants.message, messageMap);
    }
  }

  onPickImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectImageFile = File(image!.path);

      if (selectImageFile?.path.isNotEmpty == true) {
        SocketManager.setMessageList.add(
          GetOldChat(
            chatTopic: chatTopicId ?? "",
            senderId: Constant.storage.read("customerId"),
            message: "",
            messageType: 2,
            date: DateFormat("M/dd/yyyy, hh:mm:ss a").format(DateTime.now()),
            image: "",
            video: "",
          ),
        );
        SocketManager.onChatUpdate();
        SocketManager.onScrollDown();

        await createChatImageApiCall(
          senderId: Constant.storage.read("customerId"),
          receiverId: providerId ?? "",
          senderRole: "customer",
          messageType: 2,
          image: selectImageFile?.path ?? "",
          video: "",
        );
        SocketManager.setMessageList.removeLast();

        if (createChatImageModel?.status == true) {
          sendMessage(messageType: 2);
        }
      }
      update();
    }
    update([Constant.idChatImage]);
  }

  onPickVideo() async {
    video = await imagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      selectVideoFile = File(video!.path);

      if (selectVideoFile?.path.isNotEmpty == true) {
        finalThumbnail = await onPickVideoThumbnail(videoUrl: selectVideoFile?.path ?? "");

        if (finalThumbnail != null) {
          SocketManager.setMessageList.add(
            GetOldChat(
              chatTopic: chatTopicId ?? "",
              senderId: Constant.storage.read("customerId"),
              message: "",
              messageType: 3,
              date: DateFormat("M/dd/yyyy, hh:mm:ss a").format(DateTime.now()),
              image: "",
              video: "",
            ),
          );
          SocketManager.onChatUpdate();
          SocketManager.onScrollDown();

          await createChatImageApiCall(
            senderId: Constant.storage.read("customerId"),
            receiverId: providerId ?? "",
            senderRole: "customer",
            messageType: 3,
            image: finalThumbnail ?? "",
            video: selectVideoFile?.path ?? "",
          );
          SocketManager.setMessageList.removeLast();

          if (createChatImageModel?.status == true) {
            sendMessage(messageType: 3);
          }
        }
      }
      update();
    }
    update([Constant.idChatVideo]);
  }

  onPickCameraImage() async {
    camera = await imagePicker.pickImage(source: ImageSource.camera);
    if (camera != null) {
      selectCameraFile = File(image!.path);

      if (selectCameraFile?.path.isNotEmpty == true) {
        SocketManager.setMessageList.add(
          GetOldChat(
            chatTopic: chatTopicId ?? "",
            senderId: Constant.storage.read("customerId"),
            message: "",
            messageType: 2,
            date: DateFormat("M/dd/yyyy, hh:mm:ss a").format(DateTime.now()),
            image: "",
            video: "",
          ),
        );
        SocketManager.onChatUpdate();
        SocketManager.onScrollDown();

        await createChatImageApiCall(
          senderId: Constant.storage.read("customerId"),
          receiverId: providerId ?? "",
          senderRole: "customer",
          messageType: 2,
          image: selectCameraFile?.path ?? "",
          video: "",
        );
        SocketManager.setMessageList.removeLast();

        if (createChatImageModel?.status == true) {
          sendMessage(messageType: 2);
        }
      }
      update();
    }
    update([Constant.idChatCameraPhoto]);
  }

  Future<String?> onPickVideoThumbnail({required String videoUrl}) async {
    int height = (Get.height * 0.2).toInt();
    tempPath = (await getTemporaryDirectory()).path;

    final videoThumbnail = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxHeight: height,
      timeMs: -1,
      quality: 100,
    );

    log("Video Thumbnail :: $videoThumbnail");
    return videoThumbnail;
  }

  /// =================== API Calling =================== ///

  GetOldChatModel? getOldChatModel;
  CreateChatImageModel? createChatImageModel;
  GetProviderServiceModel? getProviderServiceModel;
  GetCallEnableOrNotModel? getCallEnableOrNotModel;
  bool isLoading = false;

  getOldChatApiCall({required String senderId, required String receiverId, required String senderRole}) async {
    try {
      isLoading = true;
      update([Constant.idGetProviderService, Constant.idGetOldChat, Constant.idGetCallEnableOrNot]);

      final queryParameters = {
        "senderId": senderId,
        "receiverId": receiverId,
        "senderRole": senderRole,
      };

      log("Get Old Chat Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getOldChat + queryString);
      log("Get Old Chat Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Old Chat Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Old Chat Status Code :: ${response.statusCode}");
      log("Get Old Chat Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getOldChatModel = GetOldChatModel.fromJson(jsonResponse);
        chatTopicId = getOldChatModel?.chatTopic;
        final List<GetOldChat> chats = getOldChatModel?.chat ?? [];

        SocketManager.setMessageList.addAll(chats.reversed);

        if (SocketManager.setMessageList.isNotEmpty) {
          Map<String, dynamic> messageReadMap = {
            'messageId': SocketManager.setMessageList.last.id,
          };

          SocketManager.emit(SocketConstants.messageRead, messageReadMap);
        }

        SocketManager.onChatUpdate();

        return GetOldChatModel.fromJson(jsonResponse);
      }

      log("Get Old Chat Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Old Chat Api :: $e");
    } finally {
      isLoading = false;

      update([Constant.idGetProviderService, Constant.idGetOldChat, Constant.idGetCallEnableOrNot]);
    }
  }

  createChatImageApiCall({
    required String senderId,
    required String receiverId,
    required String senderRole,
    required int messageType,
    required String image,
    required String video,
  }) async {
    try {
      var uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.createChatImage);
      var request = http.MultipartRequest("POST", uri);
      log("Create Chat Image URL :: $uri");

      if (messageType == 2) {
        if (image.isNotEmpty) {
          var addImage = await http.MultipartFile.fromPath("image", image);
          request.files.add(addImage);
          log("Create Chat Image addImage :: $addImage");
          log("Create Chat Image Image :: $image");
        }
      } else {
        if (video.isNotEmpty) {
          var addVideo = await http.MultipartFile.fromPath("video", video);
          var addThumbnail = await http.MultipartFile.fromPath('image', image);

          request.files.add(addVideo);
          request.files.add(addThumbnail);
          log("Create Chat Video addVideo :: $addVideo");
          log("Create Chat Video addThumbnail :: $addThumbnail");
        }
      }

      request.headers.addAll({"key": ApiConstant.SECRET_KEY});

      Map<String, dynamic> requestBody = <String, dynamic>{
        "senderId": senderId,
        "receiverId": receiverId,
        "senderRole": senderRole,
        "messageType": messageType,
      };

      log("Create Chat Image Body :: $requestBody");

      Map<String, String> requestBodyString = {};

      requestBody.forEach((key, value) {
        requestBodyString[key] = value.toString();
      });

      request.fields.addAll(requestBodyString);

      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      log("Create Chat Image Status Code :: ${res.statusCode}");
      log("Create Chat Image Response :: ${res.body}");

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        createChatImageModel = CreateChatImageModel.fromJson(jsonResponse);
        return CreateChatImageModel.fromJson(jsonDecode(res.body));
      }

      log("Create Chat Image Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error Call Create Chat Image Api :: $e");
    } finally {}
  }

  getProviderServiceApiCall({required String providerId}) async {
    try {
      isLoading = true;
      update([Constant.idGetProviderService, Constant.idGetOldChat, Constant.idGetCallEnableOrNot]);

      final queryParameters = {
        "providerId": providerId,
      };

      log("Get Provider Service Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getProviderService + queryString);
      log("Get Provider Service Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Provider Service Headers :: $headers");

      var response = await http.get(url, headers: headers);

      log("Get Provider Service Status Code :: ${response.statusCode}");
      log("Get Provider Service Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getProviderServiceModel = GetProviderServiceModel.fromJson(jsonResponse);
      }

      log("Get Provider Service Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Provider Service Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetProviderService, Constant.idGetOldChat, Constant.idGetCallEnableOrNot]);
    }
  }

  getCallEnableOrNotApiCall({required String customerId, required String providerId}) async {
    try {
      isLoading = true;
      update([Constant.idGetCallEnableOrNot, Constant.idGetProviderService, Constant.idGetOldChat]);

      final queryParameters = {
        "customerId": customerId,
        "providerId": providerId,
      };

      log("Get Call Enable Or Not Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getCallEnableOrNot + queryString);
      log("Get Call Enable Or Not Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Call Enable Or Not Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Call Enable Or Not Status Code :: ${response.statusCode}");
      log("Get Call Enable Or Not Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getCallEnableOrNotModel = GetCallEnableOrNotModel.fromJson(jsonResponse);
      }

      log("Get Call Enable Or Not Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Call Enable Or Not Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetCallEnableOrNot, Constant.idGetProviderService, Constant.idGetOldChat]);
    }
  }
}
