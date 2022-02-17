import 'package:flutter/material.dart';
import 'package:fooderlich/models/tab_manager.dart';
import 'package:fooderlich/screens/explore_screen.dart';
import 'package:fooderlich/screens/grocery_screen.dart';
import 'package:fooderlich/screens/recipes_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Widget> pages = [
    const ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Fooderlich',
                style: Theme.of(context).textTheme.headline6),
            centerTitle: true,
          ),
          // body: pages[tabManager.selectedTab],
          //* Preserva el estado de todas las pantallas
          body: IndexedStack(index: tabManager.selectedTab, children: pages),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabManager.selectedTab,
              onTap: (index) => tabManager.goToTab(index),
              selectedItemColor:
                  Theme.of(context).textSelectionTheme.selectionColor,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.explore), label: 'Explore'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: 'Recipes'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: 'To Buy'),
              ]));
    });
  }
}
