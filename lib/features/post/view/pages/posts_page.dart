// ignore_for_file: avoid_print,, use_build_context_synchronously

import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loading.dart';
import 'package:client/features/post/view/widgets/post_item.dart';
import 'package:client/features/post/viewmodel/posts_viewmodel.dart';
import 'package:client/features/upload/view/pages/upload_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsViewmodel = ref.watch(postsViewmodelProvider.notifier);
    final savePostState = ref.watch(postsViewmodelProvider);

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

                          return PostItem(
                            username: post.user.username,
                            timeAgo: '15h',
                            caption: post.caption,
                            imageUrl: post.image_url,
                            onSavePost: () async {
                              await postsViewmodel.savedPost(postId: post.id);
                              savePostState?.when(
                                data: (isSaved) {
                                  if (isSaved == false) {
                                    showSnackbar(ctx, "Failed to save post");
                                  }
                                },
                                error: (error, st) {
                                  showSnackbar(ctx, error.toString());
                                },
                                loading: () {},
                              );
                            },
                            // profileImageUrl: CupertinoIcons.profile_circled,
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
