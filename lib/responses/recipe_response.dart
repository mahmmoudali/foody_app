class RecipeResponse {
  int status;
  Result result;

  RecipeResponse({this.status, this.result});

  RecipeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  Recipe recipe;

  Result({this.recipe});

  Result.fromJson(Map<String, dynamic> json) {
    recipe =
        json['recipe'] != null ? new Recipe.fromJson(json['recipe']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recipe != null) {
      data['recipe'] = this.recipe.toJson();
    }
    return data;
  }
}

class Recipe {
  List<String> ingredients;
  List<String> directions;
  List<int> reviewsScore;
  String sId;
  String userId;
  String username;
  String type;
  String title;
  String description;

  Recipe(
      {this.ingredients,
      this.directions,
      this.reviewsScore,
      this.sId,
      this.userId,
      this.username,
      this.type,
      this.title,
      this.description});

  Recipe.fromJson(Map<String, dynamic> json) {
    ingredients = json['ingredients'].cast<String>();
    directions = json['directions'].cast<String>();
    reviewsScore = json['reviews_score'].cast<int>();
    sId = json['_id'];
    userId = json['user_id'];
    username = json['username'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredients'] = this.ingredients;
    data['directions'] = this.directions;
    data['reviews_score'] = this.reviewsScore;
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
