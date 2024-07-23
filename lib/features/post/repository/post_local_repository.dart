import 'package:client/features/post/models/save_post_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'post_local_repository.g.dart';

@riverpod
PostLocalRepository postLocalRepository(PostLocalRepositoryRef ref) {
  return PostLocalRepository();
}

class PostLocalRepository {
  static const String _savedPostsBoxName = 'savedPosts';

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SavePostModelAdapter());
    await Hive.openBox<SavePostModel>(_savedPostsBoxName);
  }

  Future<List<SavePostModel>> loadSavedPosts() async {
    final box = await Hive.openBox<SavePostModel>(_savedPostsBoxName);
    return box.values.toList();
  }

  Future<void> savePosts(List<SavePostModel> posts) async {
    final box = await Hive.openBox<SavePostModel>(_savedPostsBoxName);
    await box.clear();
    await box.addAll(posts);
  }
}
