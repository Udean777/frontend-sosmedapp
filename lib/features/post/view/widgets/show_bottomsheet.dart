import 'package:client/core/utils.dart';
import 'package:client/features/post/models/post_model.dart';
import 'package:client/features/post/viewmodel/comment_viewmodel.dart';
import 'package:client/features/post/viewmodel/posts_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showCommentsBottomSheet(
  BuildContext context,
  PostModel post,
  TextEditingController commentController,
  WidgetRef ref,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5,
              width: 40,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: ScrollController(),
                itemCount: post.comments.length,
                itemBuilder: (context, index) {
                  final comment = post.comments[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundImage: null,
                          child: Icon(CupertinoIcons.person, size: 16),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    comment.user.username,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    timeAgo(comment.created_at),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(comment.content),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: "Add a comment...",
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final content = commentController.text;
                      await ref
                          .read(commentViewmodelProvider.notifier)
                          .addComment(
                            postId: post.id,
                            content: content,
                          );
                      ref.invalidate(getAllPostsProvider);
                      commentController.clear();
                    },
                    child: const Text("Send"),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
