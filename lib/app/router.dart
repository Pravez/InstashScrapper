import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:instash_scrapper/app/app_skeleton_page.dart';
import 'package:instash_scrapper/features/auth/routes.dart';
import 'package:instash_scrapper/features/auth/sign_in_page.dart';
import 'package:instash_scrapper/features/home/home_page.dart';
import 'package:instash_scrapper/features/home/routes.dart';
import 'package:instash_scrapper/features/search/routes.dart';
import 'package:instash_scrapper/features/search/search_page.dart';


part 'router.gr.dart';

@MaterialAutoRouter(replaceInRouteName: "Page,Route", routes: [
  AutoRoute(
      path: '/main',
      page: AppSkeletonPage,
      children: [homeRoute, searchRoute],
      initial: true),
  signInRouter
])
class AppRouter extends _$AppRouter {}
