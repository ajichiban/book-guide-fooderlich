import 'package:flutter/material.dart';
import 'package:fooderlich/models/fooderlich_pages.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/models/profile_manager.dart';
import 'package:fooderlich/navigation/app_link.dart';
import 'package:fooderlich/pages/home_page.dart';
import 'package:fooderlich/screens/login_screen.dart';
import 'package:fooderlich/screens/onboarding_screen.dart';
import 'package:fooderlich/screens/screens.dart';
import 'package:fooderlich/screens/splash_screen.dart';
import 'package:fooderlich/screens/webview_screen.dart';

class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  //NOTE  //* Manejadores de Estados de la App.
  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  //NOTE //* Agrega listener (y los remueve) a los manejadores de estados.
  AppRouter(
      {required this.appStateManager,
      required this.groceryManager,
      required this.profileManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);

    @override
    void dispose() {
      appStateManager.removeListener(notifyListeners);
      groceryManager.removeListener(notifyListeners);
      profileManager.removeListener(notifyListeners);
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 7
    return Navigator(
      // 8
      key: navigatorKey,
      onPopPage: _handlePopPage,
      // 9
      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),
        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
          OnboardingScreen.page(),
        if (appStateManager.isOnboardingComplete)
          Home.page(currentTab: appStateManager.getSelectedTab),
        if (groceryManager.isCreatingNewItem)
          GroceryItemScreen.page(
            onCreate: (item) {
              groceryManager.addItem(item);
            },
          ),
        if (groceryManager.selectedIndex != null)
          GroceryItemScreen.page(
            item: groceryManager.selectedGroceryItem,
            onUpdate: (item) {
              groceryManager.updateItem(item, groceryManager.selectedIndex);
            },
          ),
        if (profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),
        if (profileManager.didTapOnRaywenderlich) WebViewScreen.page(),
      ],
    );
  }

  //NOTE //* Handle que se dispara cuando el Usuario dispara un Evento de Back()
  bool _handlePopPage(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }

    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(null);
    }

    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(false);
    }

    if (route.settings.name == FooderlichPages.raywenderlich) {
      profileManager.tapOnRaywenderlich(false);
    }
    return true;
  }

  AppLink getCurrentPath() {
    // 1
    if (!appStateManager.isLoggedIn) {
      return AppLink(location: AppLink.kLoginPath);
      // 2
    } else if (!appStateManager.isOnboardingComplete) {
      return AppLink(location: AppLink.kOnboardingPath);
      // 3
    } else if (profileManager.didSelectUser) {
      return AppLink(location: AppLink.kProfilePath);
      // 4
    } else if (groceryManager.isCreatingNewItem) {
      return AppLink(location: AppLink.kItemPath);
      // 5
    } else if (groceryManager.selectedGroceryItem != null) {
      final id = groceryManager.selectedGroceryItem.id;
      return AppLink(location: AppLink.kItemPath, itemId: id);
      // 6
    } else {
      return AppLink(
          location: AppLink.kHomePath,
          currentTab: appStateManager.getSelectedTab);
    }
  }

  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    switch (newLink.location) {
      case AppLink.kProfilePath:
        profileManager.tapOnProfile(true);
        break;

      case AppLink.kItemPath:
        if (newLink.itemId != null) {
          groceryManager.setSelectedGroceryItem(newLink.itemId!);
        } else {
          groceryManager.createNewItem();
        }
        profileManager.tapOnProfile(false);
        break;

      case AppLink.kHomePath:
        appStateManager.goToTab(newLink.currentTab ?? 0);

        profileManager.tapOnProfile(false);
        groceryManager.groceryItemTapped(null);
        break;
    }
  }

  @override
  AppLink get currentConfiguration => getCurrentPath();
}
