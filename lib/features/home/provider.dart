import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/features/auth/provider.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_provider.dart';
import 'package:instash_scrapper/features/home/state.dart';
import 'package:pluto_grid/pluto_grid.dart';

final homeProvider =
    StateNotifierProvider<HomeProvider, HomeState>((ref) => HomeProvider(ref));

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider(this._ref) : super(const HomeState.loading());

  final Ref _ref;

  Future<void> logout() async {
    state = const HomeState.loggedOut();
  }
}

final selectionProvider = StateProvider<List<PlutoRow>>((ref) => []);
