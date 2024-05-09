import 'package:get/get.dart';
import 'package:quick_cuisine/Models/product_model.dart';

import '../Data/Repository/recommended_food_repo.dart';



class RecommendedFoodController extends GetxController {
  final RecommendedFoodRepo recommendedFoodRepo;
  RecommendedFoodController({required this.recommendedFoodRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<ProductModel> _recommendedFoodList = []; // private variable
  List<ProductModel> get recommendedFoodList => _recommendedFoodList;

  Future<void> getRecommendedFoodList() async {
    Response response = await recommendedFoodRepo.getRecommendedFoodList();
    if(response.statusCode == 200) {
      _recommendedFoodList = [];
      _recommendedFoodList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      //print(_popularFoodList);
      update();
    }
  }
}