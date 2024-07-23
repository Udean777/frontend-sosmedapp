import 'package:client/features/post/models/like_post_model.dart';
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
  static const String _likedPostsBoxName = 'likedPosts';

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SavePostModelAdapter());
    Hive.registerAdapter(LikePostModelAdapter());
    await Hive.openBox<SavePostModel>(_savedPostsBoxName);
    await Hive.openBox<LikePostModel>('likePosts');
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

  Future<List<LikePostModel>> loadLikePosts() async {
    final box = await Hive.openBox<LikePostModel>(_likedPostsBoxName);
    return box.values.toList();
  }

  Future<void> likePosts(List<LikePostModel> posts) async {
    final box = await Hive.openBox<LikePostModel>(_likedPostsBoxName);
    await box.clear();
    await box.addAll(posts);
  }
}
