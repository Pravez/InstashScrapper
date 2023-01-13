import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/shared/loading_state.dart';

import 'hashtag_list//hashtag_list_view.dart';
import 'hashtag_list/hashtag_list_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(hashtagListProvider).loading;

    return Column(
      children: [
        TextField(
            onSubmitted: (value) => onSubmit(context, value, ref),
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                fillColor: loading.when(
                    loading: () => Colors.grey,
                    ok: () => Colors.white,
                    error: (_) => Colors.red),
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Ajouter un hashtag ...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                prefixIcon: loading.when(
                    loading: () => Container(
                          child: const CircularProgressIndicator(),
                        ),
                    ok: () => const Icon(Icons.search),
                    error: (_) => const Icon(Icons.error)))),
        const HashtagsListView()
      ],
    );
  }

  onSubmit(BuildContext context, String value, WidgetRef ref) {
    if (ref.read(hashtagListProvider).loading is! LoadingState) {
      ref.read(hashtagListProvider.notifier).addHashtag(value).then((code) {
        if (code != 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("An error occured ($code)")));
        }
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("An error occured : $error")));
      });
    }
  }
}
