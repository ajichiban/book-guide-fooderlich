
import 'package:flutter/material.dart';
import 'package:fooderlich/theme/fooderlich_theme.dart';
import 'package:fooderlich/widgets/author_card.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints.expand(width: 370, height: 550),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mag5.png'), fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            children: [
              const AuthorCard(
                authorName: 'Mike Katz',
                title: 'Smoothie Connoisseur',
                imageProvider: AssetImage('assets/author_katz.jpeg') ,
              ),

              Expanded(
                child: Stack(
                  children: [

                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Text('Recipe', style: FooderlichTheme.lightTextTheme.headline1) 
                    ),

                    Positioned(
                      bottom: 70,
                      left: 16,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text('Smoothies', style: FooderlichTheme.lightTextTheme.headline1))
                    )

                  ],
                )
              )

            ],
          )
        ),
      ),
    );
  }
}
