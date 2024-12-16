import 'dart:async';
import 'dart:developer';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:handy/socket/socket_constants.dart';
import 'package:handy/socket/socket_manager.dart';

class CallReceiveController extends GetxController {
  dynamic args = Get.arguments;

  String? callerId;
  String? receiverId;
  String? callerImage;
  String? callerName;
  String? receiverName;
  String? receiverImage;
  String? callId;
  Timer? timer;

  @override
  void onInit() async {
    await getDataFromArgs();

    FlutterRingtonePlayer().play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true,
      volume: 0.1,
      asAlarm: false,
    );

    timer = Timer(const Duration(seconds: 30), () {
      Map<String, dynamic> callCancelMap = {
        'role': 'customer',
        'callerId': callerId,
        'receiverId': receiverId,
        'callId': callId,
      };

      SocketManager.emit(SocketConstants.callCancel, callCancelMap);
    });

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
          args[6] != null) {
        callerId = args[0];
        receiverId = args[1];
        callerImage = args[2];
        callerName = args[3];
        receiverName = args[4];
        receiverImage = args[5];
        callId = args[6];
      }
    }

    log("callerId :: $callerId");
    log("receiverId :: $receiverId");
    log("callerImage :: $callerImage");
    log("callerName :: $callerName");
    log("receiverName :: $receiverName");
    log("receiverImage :: $receiverImage");
    log("callId :: $callId");
  }

  @override
  void onClose() {
    log("Call Receive Close");
    CallReceiveController().dispose();

    FlutterRingtonePlayer().stop();
    timer?.cancel();

    super.onClose();
  }
}
