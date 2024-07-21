import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/post/view/pages/posts_page.dart';
import 'package:client/features/search/view/pages/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;

  final pages = const [
    PostsPage(),
    SearchPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset(
              selectedIndex == 0
                  ? 'assets/images/home_filled.png'
                  : 'assets/images/home_unfilled.png',
              color: selectedIndex == 0
                  ? Palette.whiteColor
                  : Palette.inactiveBottomBarItemColor,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              selectedIndex == 1
                  ? CupertinoIcons.search_circle_fill
                  : CupertinoIcons.search_circle,
              size: 25,
              color: Palette.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              selectedIndex == 2
                  ? CupertinoIcons.person_circle_fill
                  : CupertinoIcons.person_circle,
              size: 25,
              color: Palette.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
