import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black,
      currentIndex: _getSelectedIndex(context),
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/tab1');
            break;
          case 1:
            context.go('/shop');
            break;
          case 2:
            context.go('/bag');
            break;
          case 3:
            context.go('/favorite');
            break;
          case 4:
            context.go('/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Shop"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "My bag"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
      ],
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.contains('/tab1')) return 0;
    if (location.contains('/shop')) return 1;
    if (location.contains('/bag')) return 2;
    if (location.contains('/favorite')) return 3;
    if (location.contains('/profile')) return 4;
    return 0;
  }
}
