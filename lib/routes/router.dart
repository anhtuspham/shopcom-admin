import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com/screens/home/screen/home_screen.dart';
import 'package:shop_com/screens/home/screen/favorite_screen.dart';
import 'package:shop_com/screens/home/screen/profile_screen.dart';

import '../data/config/app_config.dart';
import '../screens/home/home.dart';
import '../screens/auth/screen/login_screen.dart';
import '../screens/home/screen/dashboard_screen.dart';
import '../screens/home/screen/shop_screen.dart';
import '../screens/home/screen/bag_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

GoRouter genRoute() {
  // List<MenuItem>? items = app_config.setupMenu;

  GoRoute screenLogin = GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      });

  List<GoRoute> groupHome = [];

  GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/auth',
    routes: [
      screenLogin,
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => HomeScreen(child: child),
        routes: [
          GoRoute(
            path: '/tab1',
            name: 'tab1',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/tab2',
            name: 'tab2',
            builder: (context, state) => const ShopScreen(),
          ),
          GoRoute(
            path: '/tab3',
            name: 'tab3',
            builder: (context, state) => const MyBagScreen(),
          ),
          GoRoute(
            path: '/tab4',
            name: 'tab4',
            builder: (context, state) => const FavoritesScreen(),
          ),
          GoRoute(
            path: '/tab5',
            name: 'tab5',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
  return router;
}
