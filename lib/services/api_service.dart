// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_reciepe_app/config/Utils/utils.dart';
import 'package:food_reciepe_app/config/app_url.dart';
import 'package:food_reciepe_app/model/recipe_detail_model.dart';
import 'package:food_reciepe_app/model/search_result_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<SearchResult>> fetchRecipes(String query,BuildContext context) async {
    try {
      final response =
          await http.get(Uri.parse('${AppUrl.searchRecipe}&query=$query'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['results'];
        return jsonResponse
            .map((recipe) => SearchResult.fromJson(recipe))
            .toList();
      } else {
        Utils.flushBarMessage("Failed to load recipes", context, true);
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }

  Future<RecipeDetail> fetchRecipeDetail(int recipeId,context) async {
    final response = await http.get(Uri.parse('${AppUrl.recipeDetails}$recipeId/${AppUrl.recipeDetailInformation}'));
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return RecipeDetail.fromJson(jsonResponse);
      } catch (e) {
        Utils.flushBarMessage("Failed to load Recipe Detail", context, true);
        throw Exception('Error parsing recipe details: $e');
      }
    } else {
      Utils.flushBarMessage("Failed to load Recipe Detail", context, true);
      throw Exception('Failed to load recipe details');
    }
  }
}



