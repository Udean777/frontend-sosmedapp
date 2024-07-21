import 'package:client/features/post/models/post_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive/hive.dart';

part 'post_local_repository.g.dart';

@riverpod
PostLocalRepository postLocalRepository(PostLocalRepositoryRef ref) {
  return PostLocalRepository();
}

class PostLocalRepository {
  final Box box = Hive.box();

  List<PostModel> loadSongs() {
    List<PostModel> posts = [];

    for (var key in box.keys) {
      posts.add(PostModel.fromJson(box.get(key)));
    }

    return posts;
  }
}
