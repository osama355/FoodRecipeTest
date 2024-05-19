import 'package:flutter/material.dart';
import 'package:food_reciepe_app/consant/use_colors.dart';
import 'package:food_reciepe_app/provider/favourite_item_provider.dart';
import 'package:food_reciepe_app/view/screens/recipe_details.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Recipes', style: TextStyle(color: UseColors.textColor),),
        backgroundColor: UseColors.backgroundColor,
        iconTheme: IconThemeData(
          color: UseColors.textColor,
        ),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: UseColors.backgroundColor,
        child: Consumer<FavouriteItemProvider>(
          builder: (context, provider, child) {
            if (provider.favorites.isEmpty) {
              return  Center(
                child: Text(
                  'No favorite recipes.',
                  style: TextStyle(color: UseColors.textColor),
                ),
              );
            }
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final recipe = provider.favorites[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailsScreen(recipeId: recipe.id),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
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
                              IconButton(
                                icon:  Icon(Icons.favorite, color:UseColors.backgroundColor),
                                onPressed: () {
                                  provider.removeFavorite(recipe);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
