import 'package:flutter/material.dart';
import 'package:fooderlich/models/post.dart';
import 'package:fooderlich/widgets/components.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> friendPosts;

  const FriendPostListView({Key? key, required this.friendPosts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text('Social Chefs !', style: Theme.of(context).textTheme.headline1),
          
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.separated(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: friendPosts.length,
              itemBuilder: (context, index) {
                return FriendPostTile(post: friendPosts[index]);
              },
              separatorBuilder: (context, inidex) {
                return const SizedBox(height: 16);
              },
            ),
          ),
          
        ],
      ),
    );
  }
}
