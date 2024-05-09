

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_cuisine/Data/Repository/cart_repo.dart';
import 'package:quick_cuisine/Models/cart_model.dart';
import 'package:quick_cuisine/Models/product_model.dart';

import '../Utils/Colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if(totalQuantity <= 0) {
        _items.remove(product.id);
      }

    } else {
     if(quantity > 0) {
       _items.putIfAbsent(product.id!, () {
         return CartModel(
           id: product.id,
           name: product.name,
           price: product.price,
           img: product.img,
           quantity: quantity,
           isExist: true,
           time: DateTime.now().toString(),
           product: product,

         );
       });
     } else {
       Get.snackbar("Item count", "you should at least add one item to the cart !",
               backgroundColor: AppColors.mainColor,
               colorText: Colors.white,
             );
     }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool exitsInCart(ProductModel product) { // for updating quantity in ui which added early in cart
    if(_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key == product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    return total;
  }

  List<CartModel> getCartData(){ // getter
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) { // setter
    storageItems = items;
    for(int i=0; i<storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addTOCartHistoryList();
    clear();
  }

  void clear(){
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems){
    _items = {};
    _items = setItems;
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

}