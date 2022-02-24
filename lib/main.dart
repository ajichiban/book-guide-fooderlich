import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/models/profile_manager.dart';
import 'package:fooderlich/navigation/app_route_parser.dart';
import 'package:fooderlich/navigation/app_router.dart';
import 'package:fooderlich/theme/fooderlich_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const Fooderlich());

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  State<Fooderlich> createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {

  //NOTE //* se instacias todos los manejadores de estados de la app.
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  final _appStateManager = AppStateManager();

  //NOTE: //* Here, you initialize your app route parser
  final routeParser = AppRouteParser();

  //NOTE //* se instancia el router de la app.Luego se les pasas los manejadores de estados.
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      groceryManager: _groceryManager,
      profileManager: _profileManager
    );
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
        ChangeNotifierProvider(create: (context) => _appStateManager,),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderlichTheme.dark();
          } else {
            theme = FooderlichTheme.light();
          }

          return MaterialApp.router(
            theme: theme,
            debugShowCheckedModeBanner: false,
            title: 'Fooderlich',
            routeInformationParser: routeParser,

            //NOTE //* se le pasa el router. ademas se configura el 'backbuttonDispatcher' para que el boton de atras funcione.
            backButtonDispatcher: RootBackButtonDispatcher(),
            routerDelegate: _appRouter,
          
          );
        },
      ),
    );
  }

}
