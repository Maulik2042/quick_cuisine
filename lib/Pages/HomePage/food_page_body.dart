import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quick_cuisine/Controller/popular_food_controller.dart';
import 'package:quick_cuisine/Controller/recommended_food_controller.dart';
import 'package:quick_cuisine/Models/product_model.dart';
import 'package:quick_cuisine/Routes/route_helper.dart';
import 'package:quick_cuisine/Utils/Colors.dart';
import 'package:quick_cuisine/Utils/app_constants.dart';
import 'package:quick_cuisine/Utils/dimensions.dart';
import 'package:quick_cuisine/Widgets/app_column.dart';
import 'package:quick_cuisine/Widgets/big_text.dart';
import 'package:quick_cuisine/Widgets/icon_and_text_widget.dart';
import 'package:quick_cuisine/Widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currentPageValue = 0.0;
  double scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  // For clear the memory we need to override dispose method
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider section
        GetBuilder<PopularFoodController>(builder: (ctrl) {
          return ctrl.isLoaded ? Container(
            height: Dimensions.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: ctrl.popularFoodList.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(
                      position, ctrl.popularFoodList[position]);
                }),
          ) : CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        // dots
        GetBuilder<PopularFoodController>(builder: (ctrl) {
          return DotsIndicator(
            dotsCount: ctrl.popularFoodList.isEmpty ? 1 : ctrl.popularFoodList
                .length,
            position: currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        // Popular Text
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: '.', color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food pairing'),
              )
            ],
          ),
        ),
        // List of food items
        //SizedBox(height: Dimensions.height10,),
        GetBuilder<RecommendedFoodController>(builder: (ctrl) {
          return ctrl.isLoaded ?  ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ctrl.recommendedFoodList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.width10),
                  child: Row(
                    children: [
                      // Image container
                      Container(
                        height: Dimensions.listViewImageSize,
                        width: Dimensions.listViewImageSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.radius20),
                          color: Colors.white38,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  AppConstants.BASE_URL + AppConstants.UPLOAD_URL + ctrl.recommendedFoodList[index].img!),
                        ),
                      ),
                      ),
                      // text container
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextContainer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BigText(text: ctrl.recommendedFoodList[index].name!),
                                SizedBox(height: Dimensions.height10),
                                SmallText(text: 'With indian characteristic'),
                                SizedBox(height: Dimensions.height10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                      icon: Icons.circle_sharp,
                                      text: 'Normal',
                                      iconColor: AppColors.iconColor1,
                                    ),
                                    IconAndTextWidget(
                                        icon: Icons.location_on,
                                        text: '1.7km',
                                        iconColor: AppColors.mainColor),
                                    IconAndTextWidget(
                                        icon: Icons.access_time_rounded,
                                        text: '32min',
                                        iconColor: AppColors.iconColor2),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ) : CircularProgressIndicator(
            color: AppColors.mainColor,
          ) ;
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularFood) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == currentPageValue.floor()) {
      // current slide
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTransform = height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransform, 0);
    } else if (index == currentPageValue + 1) {
      // next slide
      var currentScale =
          scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currentTransform = height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransform, 0);
    } else if (index == currentPageValue - 1) {
      // before slide
      var currentScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currentTransform = height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransform, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getFoodDetails(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Color(0xFF69c5df),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularFood.img!)
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    )
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: 15,
                  right: 15,
                ),
                child: AppColumn(text: popularFood.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
