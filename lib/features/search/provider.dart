import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/features/search/state.dart';
import 'package:instash_scrapper/shared/api_provider.dart';
import 'package:instash_scrapper/shared/app_exception.dart';

final searchProvider = StateNotifierProvider<SearchProvider, SearchState>((ref) {
  final client = ref.watch(apiProvider);

  return SearchProvider(ref, client);
});

class SearchProvider extends StateNotifier<SearchState> {
  SearchProvider(this._ref, this._client) : super(const SearchState.initial());

  final Ref _ref;
  final InstashScrapper _client;

  Future<AppException?> get(String name) async {
    state = const SearchState.loading();
    final result = await _client.hashtagsNameHistoryGet(name: name);
    if (result.isSuccessful) {
      state = SearchState.data(result.body ?? List.empty());

      return Future.value(null);
    }

    return Future.error(
        const AppException.errorWithMessage("An error occured"));
  }
}
