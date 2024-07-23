// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllPostsHash() => r'ed0ae1cfae8ecdda1061c296cbd9045108e4b93f';

/// See also [getAllPosts].
@ProviderFor(getAllPosts)
final getAllPostsProvider = AutoDisposeFutureProvider<List<PostModel>>.internal(
  getAllPosts,
  name: r'getAllPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllPostsRef = AutoDisposeFutureProviderRef<List<PostModel>>;
String _$getSavedPostHash() => r'02dbdadae98076808388b63341949c266ca27ee5';

/// See also [getSavedPost].
@ProviderFor(getSavedPost)
final getSavedPostProvider =
    AutoDisposeFutureProvider<List<PostModel>>.internal(
  getSavedPost,
  name: r'getSavedPostProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getSavedPostHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetSavedPostRef = AutoDisposeFutureProviderRef<List<PostModel>>;
String _$getLikedPostHash() => r'5fa159b922de862e95cf72f4fdbf1a8a585d07a6';

/// See also [getLikedPost].
@ProviderFor(getLikedPost)
final getLikedPostProvider =
    AutoDisposeFutureProvider<List<LikePostModel>>.internal(
  getLikedPost,
  name: r'getLikedPostProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getLikedPostHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLikedPostRef = AutoDisposeFutureProviderRef<List<LikePostModel>>;
String _$postsViewmodelHash() => r'09d4e4ba47114101a2af17d1565ba8a54c7cd810';

/// See also [PostsViewmodel].
@ProviderFor(PostsViewmodel)
final postsViewmodelProvider =
    AutoDisposeNotifierProvider<PostsViewmodel, AsyncValue?>.internal(
  PostsViewmodel.new,
  name: r'postsViewmodelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$postsViewmodelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PostsViewmodel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
