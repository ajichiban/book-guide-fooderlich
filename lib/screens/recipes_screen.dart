import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/widgets/recipes_grid_view.dart';

class RecipesScreen extends StatelessWidget {

  RecipesScreen({Key? key}) : super(key: key);

  final exploreService = MockFooderlichService();

  @override
  Widget build(BuildContext context) {

    

    return FutureBuilder(
      future: exploreService.getRecipes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.done){

          return RecipesGridView(recipes: snapshot.data);
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}


