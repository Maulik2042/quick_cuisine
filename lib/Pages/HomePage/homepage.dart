import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quick_cuisine/Pages/HomePage/food_page_body.dart';
import 'package:quick_cuisine/Widgets/big_text.dart';
import 'package:quick_cuisine/Widgets/small_text.dart';

import '../../Utils/Colors.dart';
import '../../Utils/dimensions.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          // header of the homePage
          Container(
            child: Container(
              margin:  EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
              padding:  EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: 'India', color: AppColors.mainColor,),
                      Row(
                        children: [
                          SmallText(text: 'Botad',color: Colors.black54,),
                          Icon(Icons.arrow_drop_down_rounded),
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      height: Dimensions.height45,// height45 and width45 both value same
                      width: Dimensions.height45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                      ),
                      child: Icon(Icons.search,color: Colors.white,size: Dimensions.iconSize24),
                    ),
                  )
                ],
              ),
            ),

          ),
          // body of the homePage
          Expanded(child: SingleChildScrollView(child: FoodPageBody())),
        ],
      ),
    );
  }
}
