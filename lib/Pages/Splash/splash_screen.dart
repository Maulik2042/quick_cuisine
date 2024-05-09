import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_cuisine/Routes/route_helper.dart';

import '../../Controller/popular_food_controller.dart';
import '../../Controller/recommended_food_controller.dart';
import '../../Utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularFoodController>().getPopularFoodList();
    await Get.find<RecommendedFoodController>().getRecommendedFoodList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      const Duration(seconds: 3),
      () => Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
          child: Center(child: Image.asset("assets/images/logo.png",width: Dimensions.splashImage,))),
          Center(child: Image.asset("assets/images/logo_2.png",width: Dimensions.splashFont,),)
        ],
      ),
    );
  }
}
