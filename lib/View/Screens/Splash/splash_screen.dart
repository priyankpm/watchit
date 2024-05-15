import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchit/Controller/home_controller.dart';
import 'package:watchit/View/Constant/app_assets.dart';
import 'package:watchit/View/Constant/color_utils.dart';
import 'package:watchit/View/Screens/BottomBar/bottom_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.getMovieList(context);
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const BottomBarScreen(), transition: Transition.fadeIn);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: Center(
        child: Image.asset(AppAssets.logo),
      ),
    );
  }
}
