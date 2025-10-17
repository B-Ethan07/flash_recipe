import 'package:flash_recipe/screens/add_post_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    AddPostPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.blue[900],
          child: GNav(
            gap: 4,
            activeColor: Colors.white,
            color: Colors.black,
            tabBackgroundColor: Theme
                .of(context)
                .colorScheme
                .secondary,
            padding: const EdgeInsets.all(16),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() => _selectedIndex = index);
            },
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.post_add, text: 'Add Post'),
            ],
          ),
        ),
      ),
    );
  }
}