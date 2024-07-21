// ignore_for_file: avoid_print

import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/widgets/loading.dart';
import 'package:client/features/post/viewmodel/posts_viewmodel.dart';
import 'package:client/features/upload/view/pages/upload_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: Column(
        children: [
          ref.watch(getAllPostsProvider).when(
                data: (posts) {
                  return Expanded(
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: posts.length,
                        itemBuilder: (ctx, index) {
                          final post = posts[index];

                          print(post);

                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(post.image_url),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      post.user.username,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      post.caption,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                error: (error, st) {
                  // print(error);
                  return Center(
                    child: Text(
                      error.toString(),
                    ),
                  );
                },
                loading: () => const Loading(),
              )
        ],
      ),
    );
  }
}
