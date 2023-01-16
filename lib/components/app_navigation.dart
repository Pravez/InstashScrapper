import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/app.dart';
import 'package:instash_scrapper/theme.dart';
import 'package:window_manager/window_manager.dart';

class AppNavigation extends ConsumerWidget {
  const AppNavigation({required this.content, super.key});

  final Widget content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = FluentTheme.of(context);

    return NavigationView(
        appBar: NavigationAppBar(
            leading: null,
            automaticallyImplyLeading: true,
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
                      checked: FluentTheme.of(context).brightness.isDark,
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
        content: content);
  }
}
