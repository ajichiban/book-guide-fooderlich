import 'package:flutter/material.dart';
import 'package:fooderlich/screens/explore_screen.dart';
import 'package:fooderlich/screens/recipes_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  static List<Widget> pages = [
    ExploreScreen(),
    RecipesScreen(),
    Container(color: Colors.blue),
  ];
  

  // static List<Widget> pages = <Widget>[
  //   Card1(
  //       recipe: ExploreRecipe(
  //           authorName: 'Ray Wenderlich',
  //           title: 'The Art of Dough',
  //           subtitle: 'Editor\'s Choice',
  //           message: 'Learn to make the perfect bread.',
  //           backgroundImage: 'assets/magazine_pics/card_bread.jpg')),
  //   Card2(
  //       recipe: ExploreRecipe(
  //           authorName: 'Mike Katz',
  //           role: 'Smoothie Connoisseur',
  //           profileImage: 'assets/magazine_pics/mag2.png',
  //           title: 'Recipe',
  //           subtitle: 'Smoothies',
  //           backgroundImage: 'assets/magazine_pics/mag2.png')),
  //   Card3(
  //       recipe: ExploreRecipe(
  //           title: 'Vegan Trends',
  //           tags: [
  //             'Healthy',
  //             'Vegan',
  //             'Carrots',
  //             'Greens',
  //             'Wheat',
  //             'Pescetarian',
  //             'Mint',
  //             'Lemongrass',
  //             'Salad',
  //             'Water'
  //           ],
  //           backgroundImage: 'assets/magazine_pics/mag3.png')),
  // ];
// 9
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Fooderlich', style: Theme.of(context).textTheme.headline6),
          centerTitle: true,
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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
  }
}
