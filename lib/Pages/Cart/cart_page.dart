import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quick_cuisine/Base/empty_data_page.dart';
import 'package:quick_cuisine/Controller/cart_controller.dart';
import 'package:quick_cuisine/Controller/popular_food_controller.dart';
import 'package:quick_cuisine/Utils/Colors.dart';
import 'package:quick_cuisine/Utils/app_constants.dart';
import 'package:quick_cuisine/Widgets/app_icon.dart';
import 'package:quick_cuisine/Widgets/big_text.dart';
import 'package:quick_cuisine/Widgets/small_text.dart';
import 'package:get/get.dart';
import '../../Controller/recommended_food_controller.dart';
import '../../Routes/route_helper.dart';
import '../../Utils/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  SizedBox(width: Dimensions.width20 * 5,),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  )
                ],
              )),
          GetBuilder<CartController>(builder: (ctrl) {

            return ctrl.getItems.isNotEmpty? Positioned(
                top: Dimensions.height20 * 5,
                right: Dimensions.width20,
                left: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (ctrl) {
                      var _cartList = ctrl.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index) {
                            return Container(
                                width: double.maxFinite,
                                height: Dimensions.height20 * 5,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex = Get
                                            .find<PopularFoodController>()
                                            .popularFoodList
                                            .indexOf(_cartList[index].product!);
                                        if (popularIndex >= 0) {
                                          Get.toNamed(
                                              RouteHelper.getFoodDetails(
                                                  popularIndex, "cartpage"));
                                        } else {
                                          var recommendedIndex = Get
                                              .find<RecommendedFoodController>()
                                              .recommendedFoodList
                                              .indexOf(
                                              _cartList[index].product!);
                                          if (recommendedIndex < 0) {
                                            Get.snackbar("History product",
                                              "Product review is not available for history products",
                                              backgroundColor: AppColors
                                                  .mainColor,
                                              colorText: Colors.white,
                                            );
                                          } else {
                                            Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                    recommendedIndex,
                                                    "cartpage"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.width20 * 5,
                                        // for checking otherwise it will be height20
                                        height: Dimensions.height20 * 5,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD_URL +
                                                      ctrl.getItems[index].img!)
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                        ),

                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10,),
                                    Expanded(child: Container(
                                      height: Dimensions.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          BigText(
                                            text: ctrl.getItems[index].name!,
                                            color: Colors.black54,),
                                          SmallText(text: 'Spicy'),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              BigText(
                                                text: ctrl.getItems[index].price
                                                    .toString(),
                                                color: Colors.redAccent,),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          ctrl.addItem(
                                                              _cartList[index]
                                                                  .product!,
                                                              -1);
                                                        },
                                                        child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor)),
                                                    SizedBox(width: Dimensions
                                                        .width10 / 2),
                                                    BigText(
                                                        text: _cartList[index]
                                                            .quantity
                                                            .toString()),
                                                    //ctrl.inCartItems.toString()
                                                    SizedBox(width: Dimensions
                                                        .width10 / 2),
                                                    GestureDetector(
                                                        onTap: () {
                                                          ctrl.addItem(
                                                              _cartList[index]
                                                                  .product!, 1);
                                                        },
                                                        child: Icon(Icons.add,
                                                            color: AppColors
                                                                .signColor)),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                )
                            );
                          });
                    }),
                  ),
                )

            ) : EmptyDataPage(text: 'Your cart is empty!');
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (ctrl) {
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
          child: ctrl.getItems.isNotEmpty?Row(
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
                    SizedBox(width: Dimensions.width10 / 2),
                    BigText(text: "₹ " + ctrl.totalAmount.toString()),
                    SizedBox(width: Dimensions.width10 / 2),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  ctrl.addToHistory();
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      bottom: Dimensions.height15,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(text: 'Check Out',
                      color: Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ) : Container(),
        );
      }),
    );
  }
}
