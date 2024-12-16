import 'package:flutter/material.dart';
import 'package:handy/ui/video_call_screen/widget/video_call_widget.dart';
import 'package:handy/utils/app_color.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.white,
      body: const VideoCallView(),
    );
  }
}
