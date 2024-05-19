import 'package:flutter/material.dart';
import 'package:food_reciepe_app/consant/use_colors.dart';
import 'package:food_reciepe_app/model/search_result_model.dart';
import 'package:food_reciepe_app/provider/favourite_item_provider.dart';
import 'package:provider/provider.dart';

class RecipeCard extends StatelessWidget {
  final SearchResult recipe;
  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              recipe.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    recipe.title,
                    style:  TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: UseColors.backgroundColor,
                    ),
                  ),
                ),
                Consumer<FavouriteItemProvider>(
                  builder: (context, provider, child) {
                    final isFavorite = provider.isFavorite(recipe);
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? UseColors.backgroundColor : null,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          provider.removeFavorite(recipe);
                        } else {
                          provider.addFavorite(recipe);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
