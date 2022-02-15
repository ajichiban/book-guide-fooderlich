import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';

class RecipeThumbnail extends StatelessWidget {

  final SimpleRecipe recipe;

  const RecipeThumbnail({
    Key? key,
    required this.recipe
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              child: Image.asset(
                recipe.dishImage,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.title,
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(recipe.duration, style: Theme.of(context).textTheme.bodyText1),
            ],
          )
        ],
      ),
    );
  }
}
