import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shop_com/providers/product_detail_provider.dart';
import 'package:shop_com/providers/product_provider.dart';
import 'package:shop_com/screens/favorite/screen/favorite_screen.dart';
import 'package:shop_com/screens/product/screen/product_detail_screen.dart';
import 'package:shop_com/screens/profile/screen/order_detail.dart';
import 'package:shop_com/screens/profile/screen/order_screen.dart';
import 'package:shop_com/screens/profile/screen/profile_screen.dart';
import 'package:shop_com/screens/profile/screen/setting_screen.dart';

import '../data/config/app_config.dart';
import '../data/model/auth_user.dart';
import '../screens/home/home.dart';
import '../screens/auth/screen/login_screen.dart';
import '../screens/home/screen/dashboard_screen.dart';
import '../screens/shop/screen/shop_screen.dart';
import '../screens/my_bag/screen/bag_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

FutureOr<String?> systemRedirect(BuildContext context, GoRouterState state) {
  AuthUser? user = app_config.user;
  if (user == null) {
    if (state.fullPath!.compareTo("/auth") != 0) {
      return '/auth';
    }
  }
  return null;
}

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
              path: '/shop',
              name: 'shop',
              builder: (context, state) => ChangeNotifierProvider(
                  create: (context) => ProductProvider()..fetchProduct(),
                  child: const ShopScreen()),
            ),
            GoRoute(
              path: '/bag',
              name: 'bag',
              builder: (context, state) => const MyBagScreen(),
            ),
            GoRoute(
              path: '/favorite',
              name: 'favorite',
              builder: (context, state) => const FavoritesScreen(),
            ),
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfileScreen(),
            ),
            GoRoute(
              path: '/setting',
              name: 'setting',
              builder: (context, state) => const SettingScreen(),
            ),
            GoRoute(
              path: '/order',
              name: 'order',
              builder: (context, state) => const OrderScreen(),
            ),
            GoRoute(
              path: '/orderDetail',
              name: 'orderDetail',
              builder: (context, state) => const OrderDetailScreen(),
            ),
            GoRoute(
              path: '/productDetail',
              name: 'productDetail',
              builder: (context, state) => ChangeNotifierProvider(
                  create: (context) =>
                      ProductDetailProvider()..fetchProductDetail(),
                  child: const ProductDetailScreen()),
            )
          ],
        ),
      ],
      redirect: systemRedirect);
  return router;
}
