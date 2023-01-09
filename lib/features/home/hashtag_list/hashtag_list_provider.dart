import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_state.dart';
import 'package:instash_scrapper/shared/api_provider.dart';
import 'package:instash_scrapper/shared/store_notifier.dart';
import 'package:rxdart/rxdart.dart';

final hashtagListProvider =
    StateNotifierProvider<HashtagListProvider, HashtagListState>(
        (ref) => HashtagListProvider(ref));

final hashtagStoreProvider =
    StateNotifierProvider<StoreNotifier<HashtagToCheck>, Set<HashtagToCheck>>(
        (ref) {
  final store = StoreNotifier<HashtagToCheck>();

  ref.listen(hashtagListProvider, (previous, next) {
    next.maybeWhen(done: (data) => store.addAll(data), orElse: () {});
  });

  return store;
});

class HashtagListProvider extends StateNotifier<HashtagListState> {
  HashtagListProvider(this.ref, [List<HashtagToCheck>? initial])
      : super(const HashtagListState.done([]));

  final Ref ref;

  void refresh() {
    final client = ref.read(apiProvider);
    client.checksGet().asStream().mapNotNull((e) => e.body).first.then((value) {
      state = HashtagListState.done(value);
    });
  }

  void addHashtag(String name) {
    state = const HashtagListState.loading();
    final client = ref.read(apiProvider);
    client.checksNamePost(name: name).then((value) => refresh());
  }
}
