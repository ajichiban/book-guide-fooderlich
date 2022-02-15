import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/widgets/components.dart';

class TodayRecipeListView extends StatelessWidget {
  final List<ExploreRecipe> recipes;

  const TodayRecipeListView({Key? key, required this.recipes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recipes of the Day',
              style: Theme.of(context).textTheme.headline1),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 400,
            color: Colors.transparent,
            child: ListView.separated(
              physics: const PageScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: recipes.length,
              itemBuilder: (context, inidex) {
                final recipe = recipes[inidex];
                return buildCard(recipe);
              },
              separatorBuilder: (context, inidex) {
                return const SizedBox(
                  width: 16,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildCard(ExploreRecipe recipe) {
    if (recipe.cardType == RecipeCardType.card1) {
      return Card1(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card2) {
      return Card2(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card3) {
      return Card3(recipe: recipe);
    } else {
      throw Exception('This card doesn\'t exist yet');
    }
  }
}
