// ignore_for_file: avoid_print

import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/widgets/loading.dart';
import 'package:client/features/post/view/widgets/post_item.dart';
import 'package:client/features/post/viewmodel/posts_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsPage extends ConsumerStatefulWidget {
  const PostsPage({super.key});

  @override
  ConsumerState<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends ConsumerState<PostsPage> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    final postsAsyncValue = ref.watch(getAllPostsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        centerTitle: true,
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
      body: postsAsyncValue.when(
        data: (posts) {
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (ctx, index) {
              final post = posts[index];

              return PostItem(
                post: post,
                currentUser: user,
                commentController: commentController,
              );
            },
          );
        },
        error: (error, st) {
          print(error);
          return Center(
            child: Text(
              error.toString(),
            ),
          );
        },
        loading: () => const Loading(),
      ),
    );
  }
}
