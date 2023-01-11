import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:instash_scrapper/features/home/hashtag_list/hashtag_list_provider.dart';

class AppSkeletonPage extends ConsumerWidget {
  const AppSkeletonPage({super.key});

  @override
  Widget build(context, WidgetRef ref) {
    return AutoTabsScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(hashtagListProvider.notifier).refresh(),
        child: const Icon(Icons.refresh),
      ),
      appBarBuilder: (context, tabsRouter) => AppBar(
        title: const Text("InstashScrapper"),
        actions: [
          IconButton(
              onPressed: () {
                //TODO
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      routes: [HomeRoute(), SearchRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
          ],
        );
      },
    );
  }
}
