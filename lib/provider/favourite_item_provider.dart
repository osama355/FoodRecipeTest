import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_reciepe_app/model/search_result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteItemProvider extends ChangeNotifier {
  List<SearchResult> _favorites = [];

  List<SearchResult> get favorites => _favorites;

  FavouriteItemProvider() {
    _loadFavorites();
  }

  void addFavorite(SearchResult recipe) {
    _favorites.add(recipe);
    _saveFavorites();
    notifyListeners();
  }

  void removeFavorite(SearchResult recipe) {
    _favorites.remove(recipe);
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(SearchResult recipe) {
    return _favorites.any((item) => item.id == recipe.id);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesString = prefs.getString('favorites');
    if (favoritesString != null) {
      final List<dynamic> favoritesJson = json.decode(favoritesString);
      _favorites =
          favoritesJson.map((json) => SearchResult.fromJson(json)).toList();
    }
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String favoritesString =
        json.encode(_favorites.map((recipe) => recipe.toJson()).toList());
    prefs.setString('favorites', favoritesString);
  }
}
