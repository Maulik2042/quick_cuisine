import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_cuisine/Controller/cart_controller.dart';
import 'package:quick_cuisine/Controller/popular_food_controller.dart';
import 'package:quick_cuisine/Controller/recommended_food_controller.dart';
import 'package:quick_cuisine/Routes/route_helper.dart';
import 'Helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularFoodController>(builder: (_) {
      return GetBuilder<RecommendedFoodController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',

          // home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
