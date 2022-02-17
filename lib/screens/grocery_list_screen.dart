import 'package:flutter/material.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/screens/grocery_item_screen.dart';
import 'package:fooderlich/widgets/grocery_tile.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  const GroceryListScreen({Key? key, required this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          
          return Dismissible(
            key: Key(item.id.toString()),
            direction:  DismissDirection.endToStart,
            background: Container(
              color: Colors.red[50],
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever, 
                color: Colors.white ,
                size: 50.0,
              ),
            ),
            onDismissed: (direction) {
              manager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content:Text('${item.name} dismissed'))
              );
            },
            child: InkWell(
              child: GroceryTile(
                key: Key(item.id.toString()),
                item: item,
                onComplete: (change){
                  manager.completeItem(index, change);
                },
              ),
          
              onTap: (){
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                      orinalItem: item,
                      onUpdate: (item){
                        manager.updateItem(item, index);
                        Navigator.pop(context);
                      },
                    )
                  )
                  );
                
              },
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 1.0,),
      ),
    );
  }
}
