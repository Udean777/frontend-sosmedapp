import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/post/view/pages/posts_page.dart';
import 'package:client/features/saved/view/pages/saved_posts_page.dart';
import 'package:client/features/search/view/pages/search_page.dart';
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
    SearchPage(),
    SavedPostsPages(),
  ];

  void _onAddButtonPressed() {
    // Implement your image picking logic here
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const UploadPost(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedIndex == 1
          ? Container() // Placeholder for the add action, if needed
          : pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          if (value == 1) {
            _onAddButtonPressed();
          } else {
            setState(() {
              selectedIndex = value;
            });
          }
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
                  ? CupertinoIcons.add_circled_solid
                  : CupertinoIcons.add_circled,
              size: 25,
              color: Palette.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(
              selectedIndex == 2
                  ? CupertinoIcons.bookmark_solid
                  : CupertinoIcons.bookmark,
              size: 25,
              color: Palette.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
