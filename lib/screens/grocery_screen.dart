import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/empty_grocery_screen.dart';
import 'package:fooderlich/screens/grocery_item_screen.dart';
import 'package:fooderlich/screens/grocery_list_screen.dart';
import 'package:provider/provider.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  buildGroceryScreen(),
      floatingActionButton:  FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Provider.of<GroceryManager>(context, listen: false).createNewItem();
        },
      ),
    );
  }
}

//* helper
Widget buildGroceryScreen() {
  return Consumer<GroceryManager>(builder: (context, manager, child) {
    if (manager.groceryItems.isNotEmpty) {
      return GroceryListScreen(manager: manager);
    } else {
      return const EmptyGroceryScreen();
    }
  });
}
