import 'dart:convert';

import 'package:quick_cuisine/Utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/cart_model.dart';

class CartRepo {
 final SharedPreferences sharedPreferences;
 CartRepo({required this.sharedPreferences});

 List<String> cart = [];
 List<String> cartHistory = [];

 void addToCartList(List<CartModel> cartList) {
   // sharedPreferences.remove(AppConstants.CART_LIST);
   // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
   // return;
    cart = [];
    var time = DateTime.now().toString();

    // convert object to string because sharedPreference only accept string
    cartList.forEach((element) {
      element.time = time; // taking a time of adding in cart History
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
   // getCartList();
 }

 List<CartModel> getCartList(){

   List<String> carts =[];
   if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
     carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
   }

   List<CartModel> cartList = [];

   carts.forEach((element) {
     cartList.add(CartModel.fromJson(jsonDecode(element)));
   });
   return cartList;
 }

 List<CartModel> getCartHistoryList(){
   if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
     cartHistory = [];
     cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
   }
   List<CartModel> cartListHistory = [];
   cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
   return cartListHistory;
 }


 void addTOCartHistoryList(){
   if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
     cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
   }
   for(int i=0; i<cart.length; i++){
     // print("history list" +cart[i]);
     cartHistory.add(cart[i]);
   }
   removeCart();
   sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
   print("The length of cart list is ${getCartHistoryList().length}");
 }

 void removeCart(){
   cart = [];
   sharedPreferences.remove(AppConstants.CART_LIST);

 }

}