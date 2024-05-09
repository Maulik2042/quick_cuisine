import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quick_cuisine/Controller/cart_controller.dart';
import 'package:quick_cuisine/Pages/Cart/cart_page.dart';
import 'package:quick_cuisine/Pages/HomePage/homepage.dart';
import 'package:quick_cuisine/Utils/app_constants.dart';
import 'package:quick_cuisine/Widgets/app_column.dart';
import 'package:quick_cuisine/Widgets/expandable_text_widget.dart';

import '../../Controller/popular_food_controller.dart';
import '../../Routes/route_helper.dart';
import '../../Utils/Colors.dart';
import '../../Utils/dimensions.dart';
import '../../Widgets/app_icon.dart';
import '../../Widgets/big_text.dart';
import '../../Widgets/icon_and_text_widget.dart';
import '../../Widgets/small_text.dart';
import 'package:get/get.dart';

class FoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const FoodDetails({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get
        .find<PopularFoodController>()
        .popularFoodList[pageId];
    Get.find<PopularFoodController>().initProduct(
        product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.foodDetailImageSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            AppConstants.BASE_URL + AppConstants.UPLOAD_URL +
                                product.img!
                        )
                    )),
              )),
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        if(page == "cartpage"){
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularFoodController>(builder: (ctrl) {
                    return GestureDetector(
                      onTap: (){
                        if(ctrl.totalItem >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          ctrl.totalItem >= 1 ?
                           Positioned(
                               right: 0, top: 0,
                               child: AppIcon(icon: Icons.circle, size: 20, iconColor: Colors.transparent, backgroundColor: AppColors.mainColor,)) :
                             Container(),
                          Get.find<PopularFoodController>().totalItem >= 1 ?
                          Positioned(
                              right: 4, top: 2,
                              child: BigText(text: Get.find<PopularFoodController>().totalItem.toString(),
                              size: 12,
                                color: Colors.white,
                              ), ):
                            Container(),
                        ],
                          ),
                    );
                  }),
                ],
              )),
          Positioned(
            top: Dimensions.foodDetailImageSize - 20,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: 'Introduce'),
                  SizedBox(height: Dimensions.height20),
                  Expanded(
                      child: SingleChildScrollView(
                          child: ExpandableTextWidget(
                              text: product.description!
                          )))
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularFoodController>(builder: (ctrl) {
        return Container(
          height: Dimensions.height120,
          padding: EdgeInsets.only(
              top: Dimensions.height25,
              bottom: Dimensions.height25,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    bottom: Dimensions.height15,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          ctrl.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor)),
                    SizedBox(width: Dimensions.width10 / 2),
                    BigText(text: ctrl.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10 / 2),
                    GestureDetector(
                        onTap: () {
                          ctrl.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  ctrl.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      bottom: Dimensions.height15,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(text: '\$ ${product.price!} | Add to cart',
                      color: Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
