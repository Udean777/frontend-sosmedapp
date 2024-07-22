import 'package:client/core/widgets/loading.dart';
import 'package:client/features/post/viewmodel/posts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedPostsPages extends ConsumerWidget {
  const SavedPostsPages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getSavedPostProvider).when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx, index) {
                final post = data[index];

                print(data);

                return ListTile(
                  title: Center(
                    child: Text(
                      post.caption,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              },
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
        );
  }
}
