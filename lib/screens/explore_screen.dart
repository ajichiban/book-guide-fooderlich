import 'package:flutter/material.dart';
import 'package:fooderlich/widgets/friend_post_list_view.dart';
import '../api/mock_fooderlich_service.dart';
import '../widgets/components.dart';

class ExploreScreen extends StatefulWidget {

  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // 1
  final mockService = MockFooderlichService();

  late ScrollController _controller;

  @override
  void initState(){
    _controller = ScrollController();

    _controller.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener(){

    if(_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange){
      print('i am at the bottom!');
    }

    if(_controller.offset <= _controller.position.minScrollExtent && !_controller.position.outOfRange){
      print('i am at the top!');
    }

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data.todayRecipes;
          return ListView(
            controller: _controller,
            children: [
              TodayRecipeListView(recipes: recipes),
              const SizedBox(
                height: 16,
              ),
              FriendPostListView(friendPosts: snapshot.data.friendPosts),
              
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
