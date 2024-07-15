import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/post/view/pages/posts_page.dart';
import 'package:client/features/upload/view/pages/upload_post.dart';
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
    UploadPost(),
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
            label: "Home",
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
            label: "Upload",
            icon: Icon(
              selectedIndex == 1
                  ? CupertinoIcons.add_circled_solid
                  : CupertinoIcons.add_circled,
              size: 25,
              color: Palette.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
