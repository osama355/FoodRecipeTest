import 'package:food_reciepe_app/model/extended_ingrediant.dart';

class RecipeDetail {
  final String title;
  final String image;
  final int readyInMinutes;
  final int servings;
  final double pricePerServing;
  final String sourceUrl;
  final String instructions;
  final List<Ingredient> extendedIngredients;

  RecipeDetail({
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.pricePerServing,
    required this.sourceUrl,
    required this.instructions,
    required this.extendedIngredients,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) {
    var ingredientsJson = json['extendedIngredients'] as List;
    List<Ingredient> ingredientsList = ingredientsJson.map((i) => Ingredient.fromJson(i)).toList();

    return RecipeDetail(
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      pricePerServing: json['pricePerServing'],
      sourceUrl: json['sourceUrl'],
      instructions: json['instructions'],
      extendedIngredients: ingredientsList,
    );
  }
}