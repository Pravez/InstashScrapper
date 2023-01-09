import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/shared/app_exception.dart';

import 'hashtag_list/hashtag_list_provider.dart';
import 'hashtag_list//hashtag_list_view.dart';
import 'hashtag_list/hashtag_list_state.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hashtagList = ref.watch(hashtagListProvider);

    return Column(
      children: [
        TextField(
            onSubmitted: (value) => onSubmit(value, ref),
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                hintText: 'Ajouter un hashtag ...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                prefixIcon: hashtagList.when(
                    loading: () => const CircularProgressIndicator(),
                    done: (_) => const Icon(Icons.search),
                    error: (err) => const Icon(Icons.error_outline)))),
        HashtagsListView()
      ],
    );
  }

  onSubmit(String value, WidgetRef ref) {
    if (ref.read(hashtagListProvider) is! HashtagListLoading) {
      ref.read(hashtagListProvider.notifier).addHashtag(value);
    }
  }
}
