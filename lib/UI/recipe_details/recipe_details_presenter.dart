import 'package:dio/dio.dart';
import 'package:foody_app/responses/recipe_response.dart';

class RecipeDetailsPresenter {
  static const String _baseUrl =
      "https://resourceserver.foody.cyou/recipes/608008faa948fd0015dd07f2";
  final Dio _dio;
  RecipeDetailsPresenter({Dio dio}) : _dio = dio ?? Dio();
  Future<RecipeResponse> getRecipeDetails() async {
    final response = await _dio.get(_baseUrl);
    //check response
    if (response.statusCode == 200) {
      print("Request Success!");
      print("Response : " + response.data.toString());

      return RecipeResponse.fromJson(response.data);
    } else {
      print("Request Error" + response.statusMessage);
      return null;
    }
  }
}
