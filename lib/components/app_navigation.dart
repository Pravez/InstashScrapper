import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/app.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:instash_scrapper/features/settings/settings_page.dart';
import 'package:instash_scrapper/theme.dart';
import 'package:window_manager/window_manager.dart';

final navigationProvider = StateProvider((ref) => 0);

typedef WidgetRefCallback = void Function(WidgetRef ref);

class AppNavigationPaneItem {
  final String title;
  final String? contentHeader;
  final Widget contentWidget;
  final Icon icon;
  final WidgetRefCallback? onTap;

  AppNavigationPaneItem(
      {required this.title,
      required this.contentWidget,
      required this.icon,
      this.contentHeader,
      this.onTap});
}

class AppNavigation extends ConsumerWidget {
  const AppNavigation({this.content, this.panes, super.key});

  final Widget? content;
  final List<AppNavigationPaneItem>? panes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);
    final themeState = ref.watch(themeProvider);
    final navigationState = ref.watch(navigationProvider);

    return NavigationView(
        appBar: NavigationAppBar(
            leading: null,
            automaticallyImplyLeading: false,
            title: kIsWeb
                ? const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text("InstashScrapper"),
                  )
                : const DragToMoveArea(
                    child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text("InstashScrapper"),
                  )),
            actions: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: ToggleSwitch(
                      checked: themeState.mode == ThemeMode.dark,
                      onChanged: (v) {
                        if (v) {
                          ref.read(themeProvider.notifier).state = AppTheme()
                            ..mode = ThemeMode.dark;
                        } else {
                          ref.read(themeProvider.notifier).state = AppTheme()
                            ..mode = ThemeMode.light;
                        }
                      }),
                ),
                if (!kIsWeb)
                  SizedBox(
                    width: 138,
                    height: 50,
                    child: WindowCaption(
                      brightness: theme.brightness,
                      backgroundColor: Colors.transparent,
                    ),
                  )
              ],
            )),
        pane: panes != null
            ? NavigationPane(
                selected: navigationState,
                onChanged: (index) => ref
                    .read(navigationProvider.notifier)
                    .update((state) => state = index),
                displayMode: PaneDisplayMode.compact,
                footerItems: [
                  PaneItem(
                      icon: const Icon(FluentIcons.sign_out),
                      body: Container(),

                      onTap: () {
                        ref.read(navigationProvider.notifier).update((state) => state = 0);
                        GetIt.I.get<AppRouter>().navigateNamed("/signIn");
                      }),
                  PaneItem(
                      icon: const Icon(FluentIcons.settings),
                      title: const Text("Settings"),
                      body: _NavigationBodyItem(
                        content: SettingsPage(),
                      ))
                ],
                items: panes!
                    .map((e) => PaneItem(
                        icon: e.icon,
                        title: Text(e.title),
                        onTap: e.onTap != null ? () => e.onTap!(ref) : null,
                        body: _NavigationBodyItem(
                          header: e.contentHeader,
                          content: e.contentWidget,
                        )))
                    .toList()
                    .cast<NavigationPaneItem>())
            : null,
        content: content);
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
      header: header != null ? PageHeader(title: Text(header!)) : null,
      content: content ?? const SizedBox.shrink(),
    );
  }
}
