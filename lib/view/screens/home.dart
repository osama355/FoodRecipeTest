import 'package:flutter/material.dart';
import 'package:food_reciepe_app/config/routes/routes.dart';
import 'package:food_reciepe_app/consant/use_colors.dart';
import 'package:food_reciepe_app/provider/favourite_item_provider.dart';
import 'package:food_reciepe_app/provider/search_provide.dart';
import 'package:food_reciepe_app/view/components/recipe_card.dart';
import 'package:food_reciepe_app/view/screens/recipe_details.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App', style: TextStyle(color: UseColors.textColor),),
        backgroundColor: UseColors.backgroundColor,
        actions: [
          Consumer<FavouriteItemProvider>(
            builder: (context, provider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite , color: UseColors.textColor,),
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.favourite);
                    },
                  ),
                  if (provider.favorites.isNotEmpty)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: UseColors.textColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${provider.favorites.length}',
                          style:  TextStyle(
                            color: UseColors.backgroundColor,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Container(
        color: UseColors.backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search for a recipe',
                  hintStyle: TextStyle(color: UseColors.backgroundColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon:  Icon(Icons.search, color: UseColors.backgroundColor,),
                    onPressed: () {
                      final query = controller.text;
                      if (query.isNotEmpty) {
                        Provider.of<SearchProvider>(context, listen: false)
                            .fetchRecipes(query, context);
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator(color: UseColors.textColor,));
                  }
                  if (provider.results.isEmpty) {
                    return  Center(child: Text('No recipes found.', style: TextStyle(color: UseColors.textColor),));
                  }
                  return ListView.builder(
                    itemCount: provider.results.length,
                    itemBuilder: (context, index) {
                      final result = provider.results[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailsScreen(recipeId: result.id),
                            ),
                          );
                        },
                        child: RecipeCard(recipe: result),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

