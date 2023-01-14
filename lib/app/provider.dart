import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/features/auth/provider.dart';
import 'package:instash_scrapper/features/auth/state.dart';
import 'package:instash_scrapper/features/home/provider.dart';
import 'package:instash_scrapper/features/home/state.dart';

import 'state.dart';

final appStartProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  final loginState = ref.watch(authProvider);
  final homeState = ref.watch(homeProvider);

  final appState = loginState is AppAuthenticated
      ? const AppState.authenticated()
      : const AppState.initial();

  return AppStateNotifier(appState, ref, loginState, homeState);
});

class AppStateNotifier extends StateNotifier<AppState> {
  final AuthState _authState;
  final HomeState _homeState;
  final Ref _ref;

  AppStateNotifier(
      AppState appState, this._ref, this._authState, this._homeState)
      : super(appState) {
    _init();
  }

  void _init() async {
    _authState.maybeWhen(
        loggedIn: () => state = const AppState.authenticated(),
        notLoggedIn: () => state = const AppState.authenticated(),
        orElse: () {});

    _homeState.maybeWhen(
        loggedOut: () => state = const AppState.unauthenticated(),
        orElse: () {});

    state = const AppState.unauthenticated();
    _ref.read(authProvider.notifier).check();
  }
}
