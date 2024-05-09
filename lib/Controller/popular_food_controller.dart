import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_cuisine/Controller/cart_controller.dart';
import 'package:quick_cuisine/Data/Repository/popular_food_repo.dart';
import 'package:quick_cuisine/Models/product_model.dart';

import '../Models/cart_model.dart';
import '../Utils/Colors.dart';



class PopularFoodController extends GetxController {
  final PopularFoodRepo popularFoodRepo;
  PopularFoodController({required this.popularFoodRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int  get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  List<ProductModel> _popularFoodList = []; // private variable
  List<ProductModel> get popularFoodList => _popularFoodList;
  late CartController _cart;

  Future<void> getPopularFoodList() async {
    Response response = await popularFoodRepo.getPopularFoodList();
    if(response.statusCode == 200) {
      _popularFoodList = [];
      _popularFoodList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      //print(_popularFoodList);
      update();
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);

    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0) {
      Get.snackbar("Item count", "you can not reduce more !",
      backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems > 0) {
        _quantity =-_inCartItems;
        return _quantity;
      }
      return 0;
    } else if((_inCartItems+quantity) >25){
      Get.snackbar("Item count", "you can not add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 25;
    } else {
      return quantity;
    }
  }

  void initProduct (ProductModel product,CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.exitsInCart(product);
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
      _cart.addItem(product, _quantity);

      _quantity = 0; // set quantity zero for if one item is added with 5 quantity and in same page we add 3 more item then it will become 8 in ui and it will shown in cart with 13 quantity
      _inCartItems = _cart.getQuantity(product);

      _cart.items.forEach((key, value) {
      });
      update();
  }

  int get totalItem{
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}