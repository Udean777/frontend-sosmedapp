import 'package:client/core/theme/app_palette.dart';
import 'package:client/features/upload/view/pages/upload_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsPage extends ConsumerStatefulWidget {
  const PostsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostsPageState();
}

class _PostsPageState extends ConsumerState<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social Media"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Palette.whiteColor,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.chat_bubble),
            color: Palette.whiteColor,
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const UploadPost(),
            ),
          );
        },
        backgroundColor: Palette.gradient1,
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
