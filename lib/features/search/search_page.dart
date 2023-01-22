import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_provider.dart';
import 'package:instash_scrapper/features/search/hashtag_timeline.dart';
import 'package:instash_scrapper/shared/utils.dart';

import 'provider.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hashtags = ref.watch(hashtagListProvider).hashtags;
    final searchState = ref.watch(searchProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AutoSuggestBox<String>(
            onSelected: (v) => ref
                .read(searchProvider.notifier)
                .get(v.value!)
                .handleError(context),
            controller: controller,
            leadingIcon: Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Icon(FluentIcons.tag_group)),
            placeholder: "Commencer à taper un nom de hashtag ...",
            items: hashtags
                .map((e) => AutoSuggestBoxItem(value: e.name, label: e.name!))
                .toList()),
        const SizedBox(
          height: 20,
        ),
        searchState.maybeWhen(
            loading: () => const ProgressRing(),
            data: (data) => HashtagTimeline(data: data),
            orElse: () => Container())
      ],
    );
  }
}
