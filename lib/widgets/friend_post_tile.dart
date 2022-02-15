import 'package:flutter/material.dart';
import 'package:fooderlich/models/post.dart';
import 'package:fooderlich/widgets/circle_image.dart';

class FriendPostTile extends StatelessWidget {

  final Post post;

  const FriendPostTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleImage(
            imageProvider: AssetImage(post.profileImageUrl),
            imageRadius: 20,
            ),
          const SizedBox(width: 16,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.comment), 
                Text('${post.timestamp} mins ago', style: const TextStyle(fontWeight: FontWeight.bold),)
              ]
            ),
          )
      ]),
    );
  }
}
