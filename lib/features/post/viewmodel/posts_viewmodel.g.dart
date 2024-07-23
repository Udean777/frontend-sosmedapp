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
String _$postsViewmodelHash() => r'0ad43e11eb4a40befe3bb5d729ef7529e2f71ce2';

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
