import 'package:get/get.dart';
import 'package:quick_cuisine/Data/Api/api_client.dart';
import 'package:quick_cuisine/Utils/app_constants.dart';

class RecommendedFoodRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedFoodRepo({required this.apiClient}) ;

  Future<Response> getRecommendedFoodList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI); // /api/v1/products/popular
  }
}