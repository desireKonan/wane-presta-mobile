import 'package:flutter/material.dart';
import 'package:handy/ui/splash_screen/widget/splash_screen_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashLogoView(),
    );
  }
}
