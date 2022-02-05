import 'package:flutter/material.dart';
import 'package:fooderlich/pages/home_page.dart';
import 'package:fooderlich/theme/fooderlich_theme.dart';

void main() => runApp(const Fooderlich());

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final myTheme = FooderlichTheme.dark();

    return MaterialApp(
      title: 'Fooderlich',
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage()
    );
  }
}
