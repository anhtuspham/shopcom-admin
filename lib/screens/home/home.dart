import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com_admin_web/screens/home/widgets/account.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({
    super.key,
    required this.child,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SidebarXController _sidebarController = SidebarXController(selectedIndex: 0, extended: true);
  String _selectedMenu = 'home';

  // Hard-coded menu items
  final List<Map<String, String>> _menus = [
    {'code': 'home', 'name': 'Trang chủ', 'route': '/home'},
    {'code': 'setting', 'name': 'Quản lý', 'route': '/user'},
  ];

  // Hard-coded sidebar items for Setting menu with icons
  final List<Map<String, dynamic>> _settingTabs = [
    {'code': 'user', 'name': 'Người dùng', 'route': '/user', 'icon': Icons.person},
    {'code': 'product', 'name': 'Sản phẩm', 'route': '/product', 'icon': Icons.inventory},
    {'code': 'order', 'name': 'Đơn hàng', 'route': '/order', 'icon': Icons.shopping_cart},
    {'code': 'coupon', 'name': 'Khuyến mãi', 'route': '/coupon', 'icon': Icons.local_offer}
  ];

  @override
  void initState() {
    super.initState();
    _updateSidebarBasedOnRoute();
  }

  // Update sidebar selection based on current route
  void _updateSidebarBasedOnRoute() {
    final currentRoute = GoRouter.of(context).routeInformationProvider.value.uri.path;
    setState(() {
      _selectedMenu = _menus.any((menu) => menu['route'] == currentRoute)
          ? _menus.firstWhere((menu) => menu['route'] == currentRoute)['code']!
          : 'home';

      if (_selectedMenu == 'setting') {
        final index = _settingTabs.indexWhere((tab) => tab['route'] == currentRoute);
        _sidebarController.selectIndex(index >= 0 ? index : 0);
      } else {
        _sidebarController.selectIndex(0);
      }
    });
  }

  // Build AppBar with menu buttons
  Widget _buildMenuBar() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: _menus.map((menu) {
              final isSelected = _selectedMenu == menu['code'];
              return TextButton(
                onPressed: () {
                  setState(() {
                    _selectedMenu = menu['code']!;
                  });
                  context.go(menu['route']!);
                },
                style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                  backgroundColor: isSelected ? Colors.blue.shade700 : Colors.blueGrey.shade300,
                ),
                child: Text(
                  menu['name']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(width: 4),
        // IconButton(
        //   icon: const Icon(Icons.language),
        //   onPressed: () {
        //     // Add language switch logic here
        //   },
        // ),
        const SizedBox(width: 4),
        // IconButton(
        //   icon: const Icon(Icons.account_circle),
        //   onPressed: () {
        //     // Add account logic here
        //   },
        // ),
        AccountButton(),
        const SizedBox(width: 4),
        // IconButton(
        //   icon: Icon(_sidebarController.extended ? Icons.arrow_left : Icons.arrow_right),
        //   onPressed: () {
        //     setState(() {
        //       _sidebarController.setExtended(!_sidebarController.extended);
        //     });
        //   },
        // ),
      ],
    );
  }

  // Build sidebar for Setting menu
  Widget _buildSidebar() {
    if (_selectedMenu != 'setting') return const SizedBox.shrink();

    return SidebarX(
      controller: _sidebarController,
      items: _settingTabs
          .asMap()
          .entries
          .map(
            (entry) => SidebarXItem(
          iconBuilder:(selected, hovered) {
            return Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(
                entry.value['icon'] as IconData,
                size: 24, // Consistent icon size
                color: _sidebarController.selectedIndex == entry.key ? Colors.blue.shade700 : Colors.grey,
              ),
            );
          } ,
          label: entry.value['name']!,
          onTap: () {
            context.go(entry.value['route']!);
          },
        ),
      )
          .toList(),
      theme: SidebarXTheme(
        width: 100, // Increased width for better visibility
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          border: const Border(right: BorderSide(color: Colors.grey)),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
        selectedTextStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
        itemPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        selectedItemPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        selectedItemDecoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        iconTheme: const IconThemeData(size: 24),
        selectedIconTheme: IconThemeData(size: 24, color: Colors.blue.shade700),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200, // Width when extended
        textStyle: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Material(
          color: Colors.blue.shade800,
          child: _buildMenuBar(),
        ),
      ),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}