import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/theme/fooderlich_theme.dart';

class Card3 extends StatelessWidget {
  const Card3({Key? key, required this.recipe}) : super(key: key);

  final ExploreRecipe recipe;

  List<Widget> createTagChips() {
    final chips = <Widget>[];
    recipe.tags?.take(10).forEach((element) {
      final chip = Chip(
          label: Text(element, style: FooderlichTheme.darkTextTheme.bodyText1),
          backgroundColor: Colors.black.withOpacity(0.7));
      chips.add(chip);
    });

    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            constraints: const BoxConstraints.expand(width: 370, height: 550),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(recipe.backgroundImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0))
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0))
                  ),
                ),
                
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.book, size: 40,),
                      const SizedBox(height: 8),
                      Text(recipe.title, style: FooderlichTheme.darkTextTheme.headline2),
                      const SizedBox(height: 30,)

                    ],
                  ),
                ),

                Center(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12,
                    children: createTagChips(),
                  ),
                )
                 
              ],
            ),
        )
    );
  }
}
