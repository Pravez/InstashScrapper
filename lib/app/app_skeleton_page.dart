import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/components/app_navigation.dart';
import 'package:instash_scrapper/features/home/home_page.dart';
import 'package:instash_scrapper/features/search/search_page.dart';

class AppSkeletonPage extends ConsumerWidget {
  AppSkeletonPage({super.key});

  final navigationPanes = [
    AppNavigationPaneItem(
        title: "Home",
        contentWidget: const HomePage(),
        icon: const Icon(FluentIcons.home)),
    AppNavigationPaneItem(
        title: "Search",
        contentWidget: const SearchPage(),
        icon: const Icon(FluentIcons.search)),
  ];

  @override
  Widget build(context, WidgetRef ref) {
    return AppNavigation(
      panes: navigationPanes,
    );
  }
}
