import 'package:flutter/material.dart';
import 'package:owlmart/features/home/presentation/pages/home_page.dart';
import 'package:owlmart/features/cart/presentation/pages/cart_page.dart';
import 'package:owlmart/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:owlmart/features/admin/presentation/pages/admin_dashboard_page.dart';

class MainNavigationPage extends StatefulWidget {
  final String userId;
  const MainNavigationPage({super.key, required this.userId});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages = [
    const HomePage(),
    CartPage(userId: widget.userId),
    WishlistPage(userId: widget.userId),
    const AdminDashboardPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings_outlined),
            activeIcon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ],
      ),
    );
  }
}
