import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../data/config/app_config.dart';
import '../screens/home/home.dart';
import '../screens/auth/screen/login_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter genRoute() {
  // List<MenuItem>? items = app_config.setupMenu;

  GoRoute screenLogin = GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      });

  List<GoRoute> groupHome = [];

  // if( items.isNotEmpty) {
  //   for(MenuItem _item in items) {
  //     if(_item.code.compareTo("home") == 0) {
  //       GoRoute route = GoRoute(
  //           path: "/",
  //           name: _item.code,
  //           pageBuilder: (BuildContext context, GoRouterState state) {
  //             return NoTransitionPage(
  //               child: goRouteWidget(_item.code,parent: context),
  //             );
  //           }
  //       );
  //       groupHome.add(route);
  //       if(_item.children.isNotEmpty) {
  //         for(MenuChildItem _child in _item.children) {
  //           GoRoute route = GoRoute(
  //               path: "/${_item.name}/${_child.name}",
  //               name: _child.code,
  //               pageBuilder: (BuildContext context, GoRouterState state) {
  //                 return NoTransitionPage(
  //                   child: goRouteWidget(_child.code,parent: context),
  //                 );
  //               }
  //           );
  //           groupHome.add(route);
  //         }
  //       }
  //     } else {
  //       GoRoute route = GoRoute(
  //           path: "/${_item.name}",
  //           name: _item.code,
  //           pageBuilder: (BuildContext context, GoRouterState state) {
  //             return NoTransitionPage(
  //               child: goRouteWidget(_item.code, parent: context),
  //             );
  //           }
  //       );
  //       groupHome.add(route);
  //       if(_item.children.isNotEmpty) {
  //         for(MenuChildItem _child in _item.children) {
  //           GoRoute route = GoRoute(
  //               path: "/${_item.name}/${_child.name}",
  //               name: _child.code,
  //               pageBuilder: (BuildContext context, GoRouterState state) {
  //                 return NoTransitionPage(
  //                   child: goRouteWidget(_child.code, parent: context),
  //                 );
  //               }
  //           );
  //           groupHome.add(route);
  //         }
  //       }
  //     }
  //   }
  // }
  GoRouter router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/auth',
      routes: [
        screenLogin,
        // ShellRoute(
        //   builder: (context, state, child) {
        //     return HomeScreen(
        //       // isFirstLogin: state.extra as bool?,
        //       // child: child,
        //     );
        //   },
        //   routes: groupHome.isNotEmpty? groupHome : [
        //     GoRoute(
        //         path: "/",
        //         name: "home",
        //         pageBuilder: (BuildContext context, GoRouterState state) {
        //           return NoTransitionPage(
        //             child: Offstage(),
        //             // child: goRouteWidget("home",parent: context),
        //           );
        //         }
        //     )
        //   ],
        // ),
      ],
  );
  return router;
}