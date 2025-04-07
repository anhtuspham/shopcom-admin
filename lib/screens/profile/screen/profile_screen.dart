import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header section
              _buildUserInfo(),
              const SizedBox(height: 24),

              // My Orders section
              Expanded(
                child: _buildOrderSection(),
              ),
              ElevatedButton(
                onPressed: () => context.go('/auth'),
                style: const ButtonStyle(),
                child: const Text('Log out'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/person.jpg'),
        ),
        SizedBox(width: 20),
        Column(
          children: [
            Text(
              'Pham Anh Tu',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'panhtu0902@mail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildOrderSection() {
    final menuItems = [
      {'title': 'My orders', 'trailing': 'Already have 3 orders'},
      {'title': 'Shipping addresses', 'trailing': '1 addresses'},
      {'title': 'Payment methods', 'trailing': 'Momo 0395****38'},
      {'title': 'Promocodes', 'trailing': 'You have special promocodes'},
      {'title': 'My reviews', 'trailing': 'Reviews for 4 items'},
      {'title': 'Settings', 'trailing': 'Notifications, password'},
    ];

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => const Divider(height: 0),
      itemBuilder: (context, index) => ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 6),
        title: Text(
          menuItems[index]['title']!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          menuItems[index]['trailing']!,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
        onTap: () {
          switch (index) {
            case 1:
              context.go('/setting');
              break;
            case 2:
              context.go('/setting');
              break;
          }
        },
      ),
    );
  }
}
