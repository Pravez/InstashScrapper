import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/shared/loading_state.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'hashtag_list//hashtag_list_view.dart';
import 'hashtag_list/hashtag_list_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(hashtagListProvider).loading;

    return Column(
      children: [
        CommandBar(primaryItems: [
          CommandBarButton(
              icon: const Icon(FluentIcons.database_refresh),
              label: const Text("Mettre à jour les indices"),
              onPressed: () {
                ref.read(hashtagListProvider.notifier).forceHashtagsRefresh();
              }),
          CommandBarButton(
              icon: const Icon(FluentIcons.refresh),
              label: const Text("Rafraîchir le visuel"),
              onPressed: () {
                ref.read(hashtagListProvider.notifier).refresh();
              })
        ]),
        const SizedBox(
          height: 20,
        ),
        TextBox(
          onSubmitted: (value) => onSubmit(context, value, ref),
          decoration: BoxDecoration(
            border: Border.all(width: 1.0),
          ),
          placeholder: 'Ajouter un hashtag ...',
          suffix: loading.maybeWhen(
              loading: () => const SizedBox(
                    height: 20,
                    width: 20,
                    child: ProgressRing(
                      activeColor: Colors.grey,
                    ),
                  ),
              orElse: () => null),
          prefix: Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Icon(FluentIcons.search_and_apps)),
          enabled: loading.maybeWhen(loading: () => false, orElse: () => true),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const HashtagsListView()
      ],
    );
  }

  onSubmit(BuildContext context, String value, WidgetRef ref) {
    if (ref.read(hashtagListProvider).loading is! LoadingState) {
      ref.read(hashtagListProvider.notifier).addHashtag(value).then((code) {
        if (code != 200) {
          displayInfoBar(context,
              builder: (context, close) => InfoBar(
                  severity: InfoBarSeverity.error,
                  title: const Text("An error occured"),
                  content: Text("An error occured ($code)")));
        }
      }).onError((error, stackTrace) {
        displayInfoBar(context,
            builder: (context, close) => InfoBar(
                severity: InfoBarSeverity.error,
                title: const Text("An error occured"),
                content: Text("An error occured ($error)")));
      });
    }
  }
}
