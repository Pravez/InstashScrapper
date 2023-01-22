import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/components/app_navigation.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_provider.dart';
import 'package:instash_scrapper/features/home/home_page.dart';
import 'package:instash_scrapper/features/search/search_page.dart';

class AppSkeletonPage extends ConsumerWidget {
  AppSkeletonPage({super.key});

  final navigationPanes = [
    AppNavigationPaneItem(
        title: "Home",
        contentWidget: const HomePage(),
        icon: const Icon(FluentIcons.home),
        onTap: (WidgetRef ref) {}),
    AppNavigationPaneItem(
        title: "Search",
        contentWidget: SearchPage(),
        icon: const Icon(FluentIcons.search)),
  ];

  @override
  Widget build(context, WidgetRef ref) {
    return AppNavigation(
      panes: navigationPanes,
    );
  }
}
