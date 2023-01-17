import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/features/auth/provider.dart';
import 'package:instash_scrapper/features/auth/state.dart';
import 'package:instash_scrapper/features/home/provider.dart';
import 'package:instash_scrapper/features/home/state.dart';

import 'state.dart';

final appStartProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier(ref);
});

class AppStateNotifier extends StateNotifier<AppState> {
  final Ref _ref;

  AppStateNotifier(this._ref) : super(const AppState.initial()) {
    _init();
  }

  void _init() async {
    _ref.listen(
        homeProvider,
        (previous, next) => next.maybeWhen(
            loggedOut: () => state = const AppState.unauthenticated(),
            orElse: () {}));

    _ref.listen(
        authProvider,
        (previous, next) => next.maybeWhen(
            loggedIn: () => state = const AppState.authenticated(),
            notLoggedIn: () => state = const AppState.authenticated(),
            orElse: () {}));

    state = const AppState.unauthenticated();
    _ref.read(authProvider.notifier).check();
    print("prout");
  }
}
