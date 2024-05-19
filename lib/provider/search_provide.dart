// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:food_reciepe_app/config/Utils/utils.dart';
import 'package:food_reciepe_app/model/recipe_detail_model.dart';
import 'package:food_reciepe_app/model/search_result_model.dart';
import 'package:food_reciepe_app/services/api_service.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<SearchResult> _results = [];
  bool _isLoading = false;
  RecipeDetail? _recipeDetail;

  List<SearchResult> get results => _results;
  bool get isLoading => _isLoading;
  RecipeDetail? get recipeDetail => _recipeDetail;

  Future<void> fetchRecipes(String query, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      _results = await _apiService.fetchRecipes(query, context);
    } catch (e) {
      Utils.flushBarMessage("An error occurred", context, true);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<RecipeDetail> fetchRecipeDetail(
      int recipeId, BuildContext context) async {
    _isLoading = true;

    try {
      _recipeDetail = await _apiService.fetchRecipeDetail(recipeId, context);
      return _recipeDetail!;
    } catch (e) {
      Utils.flushBarMessage("An error occured", context, true);
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
