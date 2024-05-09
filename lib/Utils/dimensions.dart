import 'package:get/get.dart';

class Dimensions{

  // getting height or width of device
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width; // 411.43


  // dynamic container size
  static double pageView = screenHeight/2.64;
  static double pageViewContainer = screenHeight/3.84;
  static double pageViewTextContainer = screenHeight/7.03;

  // dynamic height for padding and margin
  static double height10 = screenHeight/84.4;
  static double height15 = screenHeight/56.27;
  static double height20 = screenHeight/42.2;
  static double height25 = screenHeight/33.76;
  static double height30 = screenHeight/28.13;
  static double height45 = screenHeight/18.76;
  static double height120 = screenHeight/7.03;

  // dynamic width padding and margin
  static double width10 = screenHeight/84.4;
  static double width15 = screenHeight/56.27;
  static double width20 = screenHeight/42.2;
  static double width30 = screenHeight/28.13;

  // dynamic font or radius for borderRadius
  static double font12 = screenHeight/70.3;
  static double font16 = screenHeight/52.75;
  static double font20 = screenHeight/42.2;
  //static double font25 = screenHeight/33.76;
  static double font26 = screenHeight/32.46;

  static double radius15 = screenHeight/56.27;
  static double radius20 = screenHeight/42.2;
  static double radius30 = screenHeight/28.13;

  // dynamic iconSize
  static double iconSize24 = screenHeight/35.17;
  static double iconSize16 = screenHeight/52.75;
  static double iconSize30 = screenHeight/29.67;

  // List view size
  static double listViewImageSize = screenWidth/3.25;
  static double listViewTextContainer = screenWidth/3.9;

  // Food details
  static double foodDetailImageSize = screenHeight/2.41;

  // Splash Screen Dimensions
  static double splashImage = screenHeight/3.38;
  static double splashFont = screenWidth/1.17;

}