import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/app_theme.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:client/features/post/repository/post_local_repository.dart';
import 'package:client/features/post/viewmodel/posts_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

final initializationProvider = FutureProvider<void>((ref) async {
  final postLocalRepository = PostLocalRepository();
  await postLocalRepository.initHive();
  await ref.read(postsViewmodelProvider.notifier).loadSavedPosts();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();

  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  await container.read(authViewmodelProvider.notifier).initSharedPreferences();
  try {
    await container.read(authViewmodelProvider.notifier).getData();
  } catch (e) {
    // ignore: avoid_print
    print('Error during getData: $e');
  }

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currUser = ref.watch(currentUserNotifierProvider);

    ref.watch(initializationProvider);

    return MaterialApp(
      title: 'Social Media',
      theme: AppTheme.darkThemeMode,
      home: currUser == null ? const Signup() : const HomePage(),
    );
  }
}
