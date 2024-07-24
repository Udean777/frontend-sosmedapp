// ignore_for_file: avoid_print

import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loading.dart';
import 'package:client/features/post/viewmodel/comment_viewmodel.dart';
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
  final Map<String, TextEditingController> _commentControllers = {};

  @override
  void dispose() {
    _commentControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserNotifierProvider);
    final userSaved = user?.savedPosts ?? [];
    final userLiked = user?.likedPosts ?? [];

    // print("User saved (in build): $userLiked");

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
                          if (!_commentControllers.containsKey(post.id)) {
                            _commentControllers[post.id] =
                                TextEditingController();
                          }

                          // print(post);

                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: null,
                                      child: Icon(CupertinoIcons.person),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            post.user.username,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            timeAgo(post.created_at),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        "assets/images/icons8-ellipsis-90.png",
                                        width: 15,
                                        height: 15,
                                        color: Palette.greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  post.caption,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 180,
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
                                    IconButton(
                                      onPressed: () async {
                                        await ref
                                            .read(
                                                postsViewmodelProvider.notifier)
                                            .likedPost(postId: post.id);
                                      },
                                      icon: Icon(userLiked
                                              .where((save) =>
                                                  save.post_id == post.id)
                                              .toList()
                                              .isNotEmpty
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart),
                                      color: userLiked
                                              .where((like) =>
                                                  like.post_id == post.id)
                                              .toList()
                                              .isNotEmpty
                                          ? Palette.gradient2
                                          : Palette.greyColor,
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          CupertinoIcons.chat_bubble),
                                      color: Palette.greyColor,
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(CupertinoIcons.reply),
                                      color: Palette.greyColor,
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () async {
                                        await ref
                                            .read(
                                                postsViewmodelProvider.notifier)
                                            .savedPost(postId: post.id);
                                      },
                                      icon: Icon(userSaved
                                              .where((save) =>
                                                  save.post_id == post.id)
                                              .toList()
                                              .isNotEmpty
                                          ? CupertinoIcons.bookmark_solid
                                          : CupertinoIcons.bookmark),
                                      color: userSaved
                                              .where((save) =>
                                                  save.post_id == post.id)
                                              .toList()
                                              .isNotEmpty
                                          ? Palette.whiteColor
                                          : Palette.greyColor,
                                    ),
                                  ],
                                ),
                                if (post.comments.isNotEmpty) ...[
                                  const Text(
                                    'Comments:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: post.comments.length,
                                    itemBuilder: (context, commentIndex) {
                                      final comment =
                                          post.comments[commentIndex];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const CircleAvatar(
                                              radius: 12,
                                              backgroundImage: null,
                                              child: Icon(CupertinoIcons.person,
                                                  size: 12),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        comment.user.username,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        timeAgo(
                                                            comment.created_at),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(comment.content),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            _commentControllers[post.id],
                                        decoration: const InputDecoration(
                                          hintText: "Add a comment...",
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final content =
                                            _commentControllers[post.id]!.text;
                                        if (content.isNotEmpty) {
                                          await ref
                                              .read(commentViewmodelProvider
                                                  .notifier)
                                              .addComment(
                                                postId: post.id,
                                                content: content,
                                              );
                                          _commentControllers[post.id]!.clear();
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
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
              )
        ],
      ),
    );
  }
}
