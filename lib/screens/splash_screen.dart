import 'package:flutter/material.dart';
import 'package:fooderlich/models/fooderlich_pages.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  //NOTE //* Here, you define a static method to create a MaterialPage that sets the appropriateunique identifier and creates SplashScreen.

  static MaterialPage page() {
    return MaterialPage(
        name: FooderlichPages.splashPath,
        key: ValueKey(FooderlichPages.splashPath),
        child: const SplashScreen()
        );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //NOTE //* Here, you use the current context to retrieve the AppStateManager to initialize the app.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 200,
              image: AssetImage('assets/fooderlich_assets/rw_logo.png'),
            ),
            const Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
