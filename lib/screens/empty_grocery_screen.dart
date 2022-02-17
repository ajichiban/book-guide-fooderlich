import 'package:flutter/material.dart';
import 'package:fooderlich/models/tab_manager.dart';
import 'package:provider/provider.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
                aspectRatio: 16 / 11,
                child: Image.asset('assets/fooderlich_assets/empty_list.png')),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Text('No Groceries',
                    style: TextStyle(fontSize: 21.0))),
            Column(
              children: [
                const Text(
                    'Shopping for ingredients?\n'
                    'Tap the + button to write them down!',
                    textAlign: TextAlign.center),
                const SizedBox(height: 10),
                MaterialButton(
                    textColor: Colors.white,
                    child: const Text('Browser Recipes'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      Provider.of<TabManager>(context, listen: false).goToRecipes();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
