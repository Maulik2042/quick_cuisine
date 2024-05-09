import 'package:get/get.dart';
import 'package:quick_cuisine/Data/Api/api_client.dart';
import 'package:quick_cuisine/Utils/app_constants.dart';

class PopularFoodRepo extends GetxService {
  final ApiClient apiClient;
  PopularFoodRepo({required this.apiClient}) ;

  Future<Response> getPopularFoodList() async {
    return await apiClient.getData(AppConstants.POPULAR_FOOD_URL); // /api/v1/products/popular
  }
}