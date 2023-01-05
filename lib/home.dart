import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:rxdart/rxdart.dart';

import 'hashtags_list_view.dart';

final repositoryProvider = Provider((ref) =>
    InstashScrapper.create(baseUrl: Uri.tryParse("http://localhost:5000")));
final hashtagListProvider =
    StateNotifierProvider<HashtagToCheckList, List<HashtagToCheck>>(
        (ref) => HashtagToCheckList(ref));

class HashtagToCheckList extends StateNotifier<List<HashtagToCheck>> {
  HashtagToCheckList(this.ref, [List<HashtagToCheck>? initial])
      : super(initial ?? []);

  final Ref ref;

  void refresh() {
    final client = ref.read(repositoryProvider);
    client.checksGet().asStream().mapNotNull((e) => e.body).first.then((value) {
      state = value;
      print(value);
    });
  }
}

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1.0,
        child: HashtagsListView(),
      ),
      appBar: AppBar(
        title: Text("InstashScrapper"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(hashtagListProvider.notifier).refresh(),
        child: Text("~"),
      ),
    );
  }
}
