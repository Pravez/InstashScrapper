import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:instash_scrapper/features/auth/provider.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (previous, next) {
      final router = GetIt.I.get<AppRouter>();
      next.maybeWhen(
          loggedIn: () => router.navigateNamed("/main"),
          notLoggedIn: () => router.navigateNamed("/main"),
          error: (err) => router.navigateNamed("/signIn"),
          orElse: () {});
    });

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
