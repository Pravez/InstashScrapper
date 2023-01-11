import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_state.dart';
import 'package:instash_scrapper/shared/api_provider.dart';
import 'package:instash_scrapper/shared/loading_state.dart';

final hashtagListProvider =
    StateNotifierProvider<HashtagListNotifier, HashtagListState>(
        (ref) => HashtagListNotifier(ref));

class HashtagListNotifier extends StateNotifier<HashtagListState> {
  HashtagListNotifier(this.ref) : super(const HashtagListState()) {
    refresh();
  }

  final Ref ref;

  void refresh() async {
    state = state.copyWith(loading: const Loading.loading());
    final hashtags = await ref
        .read(apiProvider)
        .checksGet()
        .asStream()
        .map((e) => e.body)
        .first;
    state = state.copyWith(
        hashtags: hashtags ?? state.hashtags, loading: const Loading.ok());
  }

  Future<int> addHashtag(String name) async {
    final client = ref.read(apiProvider);
    state = state.copyWith(loading: const Loading.loading());
    final result = await client.checksNamePost(name: name);
    if (result.isSuccessful && result.body != null) {
      refresh();
    } else {
      state = state.copyWith(loading: Loading.error(result.base.statusCode));
    }

    return result.statusCode;
  }
}
