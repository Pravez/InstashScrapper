import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:instash_scrapper/app/app_skeleton_page.dart';
import 'package:instash_scrapper/app/loading_page.dart';
import 'package:instash_scrapper/features/auth/sign_in_page.dart';
import 'package:instash_scrapper/features/home/home_page.dart';
import 'package:instash_scrapper/features/search/search_page.dart';
import 'package:instash_scrapper/features/settings/settings_page.dart';

part 'router.gr.dart';

class AppRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    print("Pushed route : $route (previous was : $previousRoute");
  }
}

@MaterialAutoRouter(replaceInRouteName: "Page,Route", routes: [
  AutoRoute(path: '/main', page: AppSkeletonPage),
  AutoRoute(path: '/loading', page: LoadingPage, initial: true),
  AutoRoute(path: '/signIn', page: SignInPage),
  AutoRoute(path: '/settings', page: SettingsPage),
])
class AppRouter extends _$AppRouter {}
