import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/models/tab_manager.dart';
import 'package:fooderlich/pages/home_page.dart';
import 'package:fooderlich/theme/fooderlich_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const Fooderlich());

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final myTheme = FooderlichTheme.light();

    return MaterialApp(
      title: 'Fooderlich',
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=> TabManager()),
          ChangeNotifierProvider(create: (context) => GroceryManager()),
        ],
        child: const HomePage(),
      )
    );
  }
}
