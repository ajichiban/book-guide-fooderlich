import 'package:flutter/material.dart';
import 'package:fooderlich/models/grocery_item.dart';
import 'package:intl/intl.dart';

class GroceryTile extends StatelessWidget {

  final GroceryItem item;
  final Function(bool)? onComplete;

  const GroceryTile({
    Key? key,
    required this.item,
    this.onComplete
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80.0,
                color: item.color,
                width: 10.0,
              ),
              const SizedBox(width: 15,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name, 
                    style: TextStyle(
                      decoration: textDecoration(),
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ) ),
                  buildDate(),
                  buildImportance()
                ],
              ) 
            ]
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(item.quantity.toString(), style: TextStyle(
                decoration: textDecoration(),
                fontSize: 21.0,
              )),
              onComplete == null ? const SizedBox() : buidCheck()
            ],
          )
          
        ],
      )
    );
  }

  TextDecoration textDecoration() => (
    item.isComplete ? TextDecoration.lineThrough : TextDecoration.none 
  ); 

  Widget buildImportance(){
    
    if(item.importance == Importance.low){
      return Text('Low', style: TextStyle(decoration: textDecoration()));
    }else if(item.importance == Importance.medium){
      return Text(
        'Medium', 
        style: TextStyle(fontWeight: FontWeight.w800, decoration: textDecoration()));
    }else if(item.importance == Importance.high){
      return Text(
        'Hight', 
        style: TextStyle(
          fontWeight: FontWeight.w900, 
          decoration: textDecoration(),
          color: Colors.red
        )
      );
    }else{
      throw Exception("This Importance type does not exist");
    }
    
  }

  Widget buildDate(){
    
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(item.date);

    return Text(
      dateString,
      style: TextStyle(decoration: textDecoration())
    );
    
  }

  Widget buidCheck(){
    
    return Checkbox(
      value:item.isComplete,
      onChanged: (val){ 
        onComplete!(val!);
      },
    );
    
  }

}
