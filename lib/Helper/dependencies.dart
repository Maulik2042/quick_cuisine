import 'package:get/get.dart';
import 'package:quick_cuisine/Controller/cart_controller.dart';
import 'package:quick_cuisine/Controller/popular_food_controller.dart';
import 'package:quick_cuisine/Controller/recommended_food_controller.dart';
import 'package:quick_cuisine/Data/Api/api_client.dart';
import 'package:quick_cuisine/Data/Repository/cart_repo.dart';
import 'package:quick_cuisine/Data/Repository/popular_food_repo.dart';
import 'package:quick_cuisine/Utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/Repository/recommended_food_repo.dart';

Future<void> init() async {
 // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // Api Client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL)); // "https://mvs.bslmeiyu.com"

  // Repository
  Get.lazyPut(() => PopularFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => PopularFoodController(popularFoodRepo: Get.find()));
  Get.lazyPut(() => RecommendedFoodController(recommendedFoodRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}