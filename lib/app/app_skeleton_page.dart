import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:instash_scrapper/features/home/home_page.dart';
import 'package:instash_scrapper/features/search/search_page.dart';

final navigationProvider = StateProvider((ref) => 0);

class AppSkeletonPage extends ConsumerWidget {
  const AppSkeletonPage({super.key});

  @override
  Widget build(context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);


    return NavigationView(
      appBar: const NavigationAppBar(title: Text("InstashScrapper")),
      pane: NavigationPane(
          selected: navigationState,
          onChanged: (index) => ref
              .read(navigationProvider.notifier)
              .update((state) => state = index),
          displayMode: PaneDisplayMode.compact,
          items: [
            PaneItem(
                icon: const Icon(FluentIcons.home),
                body: const _NavigationBodyItem(
                  header: "Home",
                  content: HomePage(),
                )),
            PaneItem(
                icon: const Icon(FluentIcons.search),
                body: const _NavigationBodyItem(
                  header: "Search",
                  content: SearchPage(),
                ))
          ]),
    );
  }
}

class _NavigationBodyItem extends StatelessWidget {
  const _NavigationBodyItem({
    Key? key,
    this.header,
    this.content,
  }) : super(key: key);

  final String? header;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(title: Text(header ?? 'This is a header text')),
      content: content ?? const SizedBox.shrink(),
    );
  }
}
