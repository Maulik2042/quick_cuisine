import 'package:get/get.dart';
import 'package:quick_cuisine/Pages/Cart/cart_page.dart';
import 'package:quick_cuisine/Pages/FoodPage/food_details.dart';
import 'package:quick_cuisine/Pages/FoodPage/recommended_food_detais.dart';
import 'package:quick_cuisine/Pages/HomePage/homepage.dart';
import 'package:quick_cuisine/Pages/Splash/splash_screen.dart';

import '../Pages/HomePage/complete_home_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page" ;
  static const String initial = "/" ;
  static const String foodDetails = "/food-details";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";


  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getFoodDetails(int pageId, String page) => '$foodDetails?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [

    GetPage(name: splashPage, page: () => SplashScreen()),

    GetPage(name: initial, page: () => CompleteHomePage()),

    GetPage(name: foodDetails, page:() {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return FoodDetails(pageId: int.parse(pageId!), page: page!);
    },
     transition: Transition.fadeIn
    ),

    GetPage(name: recommendedFood, page:() {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetails(pageId: int.parse(pageId!), page: page!);
    },
        transition: Transition.fadeIn
    ),
    
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
        transition: Transition.fadeIn
    ),
  ];
}