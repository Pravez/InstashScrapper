import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:instash_scrapper/l10n/l10n.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      theme: ThemeData(
          accentColor: Colors.blue,
          visualDensity: VisualDensity.standard,
          focusTheme: const FocusThemeData(glowFactor: 0.0)),
      routerDelegate: AutoRouterDelegate(GetIt.I.get<AppRouter>(),
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
