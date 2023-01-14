import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/loading_page.dart';
import 'package:instash_scrapper/app/provider.dart';
import 'package:instash_scrapper/features/auth/sign_in_page.dart';
import 'package:instash_scrapper/features/home/home_page.dart';

class AppStartPage extends ConsumerWidget {
  const AppStartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStartProvider);

    return state.maybeWhen(
        initial: () => const LoadingPage(),
        authenticated: () => const HomePage(),
        unauthenticated: () => SignInPage(),
        orElse: () => const HomePage());
  }
}
