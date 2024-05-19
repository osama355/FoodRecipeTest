import 'package:flutter/material.dart';
import 'package:food_reciepe_app/consant/use_colors.dart';
import 'package:food_reciepe_app/model/recipe_detail_model.dart';
import 'package:food_reciepe_app/provider/search_provide.dart';
import 'package:provider/provider.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final int recipeId;
  const RecipeDetailsScreen({super.key, required this.recipeId});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  late Future<RecipeDetail> _recipeDetailFuture;
  
  @override
  void initState() {
    super.initState();
    _recipeDetailFuture = Provider.of<SearchProvider>(context, listen: false).fetchRecipeDetail(widget.recipeId, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Recipe Details', style: TextStyle(color: UseColors.textColor), ),
        backgroundColor: UseColors.backgroundColor,
        iconTheme: IconThemeData(
          color: UseColors.textColor, 
        )
      ),
      body: Container(
        color: UseColors.backgroundColor,
        child: FutureBuilder<RecipeDetail>(
          future: _recipeDetailFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Center(child: CircularProgressIndicator(color: UseColors.textColor,));
            } else if (snapshot.hasError) {
              return Center(child: Text('An error occurred: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return  Center(child: Text('No recipe details found.', style: TextStyle(color: UseColors.textColor),));
            } else {
              final recipeDetail = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      recipeDetail.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        recipeDetail.title,
                        style:  TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: UseColors.textColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Ready in ${recipeDetail.readyInMinutes} minutes',
                        style:  TextStyle(
                          fontSize: 18,
                          color: UseColors.subTextColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Servings: ${recipeDetail.servings}',
                        style:  TextStyle(
                          fontSize: 18,
                          color: UseColors.subTextColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Price per serving: \$${recipeDetail.pricePerServing}',
                        style:  TextStyle(
                          fontSize: 18,
                          color: UseColors.subTextColor,
                        ),
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Ingredients:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: UseColors.textColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: recipeDetail.extendedIngredients.map((ingredient) {
                          return Text(
                            '- ${ingredient.original}',
                            style:  TextStyle(
                              fontSize: 16,
                              color: UseColors.textColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Instructions:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        recipeDetail.instructions,
                        style:  TextStyle(
                          fontSize: 16,
                          color: UseColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
