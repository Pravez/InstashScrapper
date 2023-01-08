import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/shared/app_exception.dart';

import 'hashtag_list/hashtag_list_provider.dart';
import 'hashtag_list//hashtag_list_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _widgetContent(context, ref);
  }

  Widget _widgetShimmer(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _widgetContent(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hashtagListProvider);

    return state.when(
        loading: () => _widgetShimmer(context, ref),
        done: (hashtags) => HashtagsListView(hashtags),
        error: (AppException error) => _widgetShimmer(context, ref));
  }
}
