import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quick_cuisine/Controller/popular_food_controller.dart';
import 'package:quick_cuisine/Controller/recommended_food_controller.dart';
import 'package:quick_cuisine/Pages/Cart/cart_page.dart';
import 'package:quick_cuisine/Routes/route_helper.dart';
import 'package:quick_cuisine/Utils/Colors.dart';
import 'package:quick_cuisine/Utils/app_constants.dart';
import 'package:quick_cuisine/Widgets/app_icon.dart';
import 'package:quick_cuisine/Widgets/big_text.dart';
import 'package:quick_cuisine/Widgets/expandable_text_widget.dart';
import '../../Controller/cart_controller.dart';
import '../../Utils/dimensions.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  RecommendedFoodDetails({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get
        .find<RecommendedFoodController>()
        .recommendedFoodList[pageId];
    Get.find<PopularFoodController>().initProduct(
        product, Get.find<CartController>());
    print("pageId is $pageId");
    print("food name is ${product.name}");
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 110,
            title: Row(
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
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularFoodController>(builder: (ctrl) {
                  return GestureDetector(
                      onTap: (){
                        if(ctrl.totalItem >= 1) {
                          Get.toNamed(RouteHelper.getCartPage());
                        } },
                        child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularFoodController>().totalItem >= 1 ?
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),
                    )),
                child: Center(
                    child: BigText(
                      text: product.name!,
                      size: Dimensions.font26,
                    )),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.mainColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(
                    text:
                    product.description!,
                  ),
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularFoodController>(builder: (ctrl) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20 * 2.5,
                  right: Dimensions.width20 * 2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      ctrl.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  BigText(
                    text: "\$ ${product.price}  X  ${ctrl.inCartItems} ",
                    color: AppColors.mainBlackColor,
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                    onTap: (){
                      ctrl.setQuantity(true);
                    },
                    child: AppIcon(
                      icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                    ),
                  )
                ],
              ),
            ),
            Container(
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
                        borderRadius: BorderRadius.circular(
                            Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                        size: Dimensions.iconSize30,
                      )),
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
                      child:
                      BigText(text: '\₹ ${product.price} | Add to cart', color: Colors.white),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
