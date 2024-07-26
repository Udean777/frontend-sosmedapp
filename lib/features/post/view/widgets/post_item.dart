import 'package:client/core/models/user_model.dart';
import 'package:client/features/post/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/core/theme/app_palette.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/post/view/widgets/show_bottomsheet.dart';
import 'package:client/features/post/viewmodel/posts_viewmodel.dart';

class PostItem extends ConsumerWidget {
  final PostModel post;
  final UserModel? currentUser;
  final TextEditingController commentController;

  const PostItem({
    super.key,
    required this.post,
    required this.currentUser,
    required this.commentController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSaved = currentUser?.savedPosts ?? [];
    final userLiked = currentUser?.likedPosts ?? [];

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
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 8),
          Text(
            post.caption,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(post.image_url),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await ref
                      .read(postsViewmodelProvider.notifier)
                      .likedPost(postId: post.id);

                  ref.invalidate(getAllPostsProvider);
                },
                icon: Row(
                  children: [
                    Icon(
                      userLiked
                              .where((like) => like.post_id == post.id)
                              .toList()
                              .isNotEmpty
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    post.likes_count < 1
                        ? const Text("0")
                        : Text("${post.likes_count}"),
                  ],
                ),
                color: userLiked
                        .where((like) => like.post_id == post.id)
                        .toList()
                        .isNotEmpty
                    ? Palette.gradient2
                    : Palette.greyColor,
              ),
              IconButton(
                onPressed: () {
                  showCommentsBottomSheet(
                    context,
                    post,
                    commentController,
                    ref,
                  );
                },
                icon: Row(
                  children: [
                    const Icon(CupertinoIcons.chat_bubble),
                    const SizedBox(
                      width: 5,
                    ),
                    post.comments.isEmpty
                        ? const Text("0")
                        : Text("${post.comments.length}"),
                  ],
                ),
                color: Palette.greyColor,
              ),
              IconButton(
                onPressed: () {},
                icon: const Row(
                  children: [
                    Icon(CupertinoIcons.reply),
                    SizedBox(
                      width: 5,
                    ),
                    Text("0")
                  ],
                ),
                color: Palette.greyColor,
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  await ref
                      .read(postsViewmodelProvider.notifier)
                      .savedPost(postId: post.id);
                },
                icon: Icon(
                  userSaved
                          .where((save) => save.post_id == post.id)
                          .toList()
                          .isNotEmpty
                      ? CupertinoIcons.bookmark_solid
                      : CupertinoIcons.bookmark,
                ),
                color: userSaved
                        .where((save) => save.post_id == post.id)
                        .toList()
                        .isNotEmpty
                    ? Palette.whiteColor
                    : Palette.greyColor,
              ),
            ],
          ),
          if (post.comments.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: () {
                  showCommentsBottomSheet(
                    context,
                    post,
                    commentController,
                    ref,
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundImage: null,
                      child: Icon(CupertinoIcons.person, size: 12),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                post.comments[0].user.username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                timeAgo(post.comments[0].created_at),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Text(post.comments[0].content),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (post.comments.length > 1)
              TextButton(
                onPressed: () {
                  showCommentsBottomSheet(
                    context,
                    post,
                    commentController,
                    ref,
                  );
                },
                child: Text(
                  "View all ${post.comments.length} comments",
                  style: const TextStyle(
                    color: Palette.greyColor,
                  ),
                ),
              ),
          ],
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
