import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/theme/fooderlich_theme.dart';
import 'package:fooderlich/widgets/author_card.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key, required this.recipe}) : super(key: key);

  final ExploreRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints.expand(width: 370, height: 550),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(recipe.backgroundImage), fit: BoxFit.cover),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            children: [
              AuthorCard(
                authorName: '${recipe.authorName}',
                title: recipe.title,
                imageProvider: AssetImage('${recipe.profileImage}'),
              ),
              Expanded(
                  child: Stack(
                children: [
                  Positioned(
                      bottom: 16,
                      right: 16,
                      child: Text(recipe.title,
                          style: FooderlichTheme.lightTextTheme.headline1)),
                  Positioned(
                      bottom: 70,
                      left: 16,
                      child: RotatedBox(
                          quarterTurns: 3,
                          child: Text('${recipe.subtitle}',
                              style: FooderlichTheme.lightTextTheme.headline1)))
                ],
              ))
            ],
          )),
    );
  }
}
