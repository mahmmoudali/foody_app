import 'package:foody_app/UI/info_details/recipe_details_screen.dart';
import 'package:dio/dio.dart';
import 'package:foody_app/responses/recipe_response.dart';

class RecipeDetailsPresenter {
  static const String _baseUrl = "https://corona.lmao.ninja/v2/countries/egypt";
  final Dio _dio;
  RecipeDetailsPresenter({Dio dio}) : _dio = dio ?? Dio();
  Future<RecipeResponse> getRecipeDetails() async {
    // view.showLoading(context);
    final response = await _dio.get(_baseUrl);
    //check response
    if (response.statusCode == 200) {
      print("Request Ok" + response.statusMessage);
      print("Response : " + response.data.toString());
      // view.provider.totalCases =
      //     CovidCasesResponse.fromJson(response.data).cases.toString();
      // view.stopLoading(context);
      return RecipeResponse.fromJson(response.data);
      // return CovidCasesResponse.fromJson(response.data);

    } else {
      print("Request Error" + response.statusMessage);
      return null;
    }
  }
}
