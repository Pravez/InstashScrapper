import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:instash_scrapper/l10n/l10n.dart';
import 'package:instash_scrapper/theme.dart';

final themeProvider = StateProvider<AppTheme>((ref) => AppTheme());

class App extends HookConsumerWidget {
  App({Key? key}) : super(key: key);

  final _router = GetIt.I.get<AppRouter>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return FluentApp.router(
      theme: ThemeData(
          accentColor: theme.color,
          visualDensity: VisualDensity.standard,
          focusTheme: const FocusThemeData(glowFactor: 0.0)),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: theme.color,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen() ? 2.0 : 0.0,
        ),
      ),
      themeMode: theme.mode,
      locale: theme.locale,
      routerDelegate: AutoRouterDelegate(_router,
          navigatorObservers: () => [AppRouteObserver()]),
      routeInformationProvider: _router.routeInfoProvider(),
      routeInformationParser: _router.defaultRouteParser(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      color: Colors.blue,
    );
  }
}
