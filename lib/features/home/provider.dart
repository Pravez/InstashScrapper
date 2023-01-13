import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instash_scrapper/features/auth/provider.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_provider.dart';
import 'package:instash_scrapper/features/home/state.dart';
import 'package:pluto_grid/pluto_grid.dart';

final homeProvider =
    StateNotifierProvider<HomeProvider, HomeState>((ref) => HomeProvider(ref));

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider(this._ref) : super(const HomeState.loading()) {
    _init();
  }

  final Ref _ref;

  _init() async {
    _ref.listen(authProvider, (previous, next) {
      next.maybeWhen(
          loggedIn: () => _ref.read(hashtagListProvider.notifier).refresh(),
          orElse: () {});
    });
  }

  Future<void> logout() async {
    state = const HomeState.loggedOut();
  }
}

final selectionProvider = StateProvider<List<PlutoRow>>((ref) => []);
