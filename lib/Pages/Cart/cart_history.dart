import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quick_cuisine/Base/empty_data_page.dart';
import 'package:quick_cuisine/Controller/cart_controller.dart';
import 'package:quick_cuisine/Routes/route_helper.dart';
import 'package:quick_cuisine/Utils/app_constants.dart';
import 'package:quick_cuisine/Widgets/big_text.dart';
import 'package:quick_cuisine/Widgets/small_text.dart';

import '../../Models/cart_model.dart';
import '../../Utils/Colors.dart';
import '../../Utils/dimensions.dart';
import '../../Widgets/app_icon.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get
        .find<CartController>()
        .
    getCartHistoryList()
        .reversed
        .toList();

    Map<String, int> cartItemPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemPerOrderToList() {
      return cartItemPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat(
            "yyyy-MM-dd HH:mm:ss").parse(
            getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(
            parseDate.toString());
        var outputFormat = DateFormat(
            "dd/MM/yyyy hh:mm a");
        outputDate = outputFormat.format(
            inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(

        body: Column(
          children: [
            Container(
              height: Dimensions.height25 * 4,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: Dimensions.height45),
              color: AppColors.mainColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigText(text: 'Your Cart History', color: Colors.white,),
                  AppIcon(icon: Icons.shopping_cart_outlined,
                    iconColor: AppColors.mainColor,
                    backgroundColor: AppColors.yellowColor,)
                ],
              ),
            ),
            GetBuilder<CartController>(builder: (ctrl) {
              return ctrl.getCartHistoryList().isNotEmpty?Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for(int i = 0; i < itemsPerOrder.length; i++)
                          Container(
                            height: Dimensions.height120,
                            margin: EdgeInsets.only(
                                bottom: Dimensions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                SizedBox(height: Dimensions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(
                                          itemsPerOrder[i], (index) {
                                        if (listCounter <
                                            getCartHistoryList.length) {
                                          listCounter++;
                                        }
                                        return index <= 2 ? Container(
                                          margin: EdgeInsets.only(
                                              right: Dimensions.width10 / 2),
                                          height: Dimensions.height20 * 4,
                                          width: Dimensions.width20 * 4,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  Dimensions.radius15 / 2),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    AppConstants.BASE_URL +
                                                        AppConstants
                                                            .UPLOAD_URL +
                                                        getCartHistoryList[listCounter -
                                                            1].img!,
                                                  )
                                              )
                                          ),
                                        ) : Container();
                                      }),
                                    ),
                                    Container(
                                      height: Dimensions.height20 * 4,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .end,
                                        children: [
                                          SmallText(text: "Total",
                                              color: AppColors.titleColor),
                                          BigText(
                                            text: itemsPerOrder[i].toString() +
                                                " Items",
                                            color: AppColors.titleColor,),
                                          GestureDetector(
                                            onTap: () {
                                              var orderTime = cartOrderTimeToList();
                                              Map<int, CartModel> moreOrder = {
                                              };
                                              for (int j = 0; j <
                                                  getCartHistoryList
                                                      .length; j++) {
                                                if (getCartHistoryList[j]
                                                    .time == orderTime[i]) {
                                                  moreOrder.putIfAbsent(
                                                      getCartHistoryList[j]
                                                          .id!, () =>
                                                      CartModel.fromJson(
                                                          jsonDecode(jsonEncode(
                                                              getCartHistoryList[j])))
                                                  );
                                                }
                                              }
                                              Get
                                                  .find<CartController>()
                                                  .setItems = moreOrder;
                                              Get.find<CartController>()
                                                  .addToCartList();
                                              Get.toNamed(
                                                  RouteHelper.getCartPage());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Dimensions
                                                      .width10,
                                                  vertical: Dimensions
                                                      .height10 / 2),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(
                                                      Dimensions.radius15 / 3),
                                                  border: Border.all(width: 1,
                                                      color: AppColors
                                                          .mainColor)
                                              ),
                                              child: SmallText(text: "one more",
                                                color: AppColors.mainColor,),
                                            ),
                                          )

                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ) :
              SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                  child: const Center(
                    child: EmptyDataPage(
                      text: "You didn't buy anything so far !" ,
                      imgPath: "assets/images/empty_history.webp",),
                  ));
            })
          ],
        )
    );
  }
}
