import 'package:flutter/cupertino.dart';
import 'package:food_app_yt/data/manager/auth_manager.dart';
import 'package:food_app_yt/presentation/screen/favorite_screen.dart';
import 'package:food_app_yt/presentation/screen/main_screen.dart';
import 'package:food_app_yt/presentation/screen/onboarding_screen.dart';
import 'package:food_app_yt/presentation/screen/recipe_screen.dart';
import 'package:food_app_yt/presentation/screen/settings_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavKey = GlobalKey<NavigatorState>();
  static final _shellNavKey1 = GlobalKey<NavigatorState>();
  static final _shellNavKey2 = GlobalKey<NavigatorState>();

  static final _auth = AuthManager();

  static final router = GoRouter(
    navigatorKey: _rootNavKey,
     initialLocation: _auth.getCurrentUser() == null ? '/on_boarding' : '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavKey1,
        builder: (context, state, child) {
          return child;
        },
        routes: [
          GoRoute(
            path: '/on_boarding',
            parentNavigatorKey: _shellNavKey1,
            builder: (context, state) => const OnBoardingScreen()
          )
        ]
      ),
      ShellRoute(
          navigatorKey: _shellNavKey2,
          builder: (context, state, child) {
            return MainScreen(child: child);
          },
          routes: [
            GoRoute(
                path: '/',
                parentNavigatorKey: _shellNavKey2,
                pageBuilder: (context, state) => const NoTransitionPage(child:  RecipeScreen())
            ),
            GoRoute(
                path: '/favorites',
                parentNavigatorKey: _shellNavKey2,
                pageBuilder: (context, state) => const NoTransitionPage(child:  FavoriteScreen())
            ),
            GoRoute(
                path: '/settings',
                parentNavigatorKey: _shellNavKey2,
                pageBuilder: (context, state) => const NoTransitionPage(child:  SettingScreen())
            ),
          ]
      ),
    ]
  );
}