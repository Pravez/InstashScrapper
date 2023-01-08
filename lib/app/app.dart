import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:instash_scrapper/l10n/l10n.dart';
import 'package:instash_scrapper/app/router.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      routerDelegate: _router.delegate(),
      routeInformationProvider: _router.routeInfoProvider(),
      routeInformationParser: _router.defaultRouteParser(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
