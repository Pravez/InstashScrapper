import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'app/app.dart';
import 'features/settings/settings_data.dart';
import 'observer.dart';

bool get isDesktop {
  if (kIsWeb) return false;

  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

Future<void> init() async {
  GetIt.I.registerSingleton<AppRouter>(AppRouter());

  await Hive.initFlutter();
  Hive.registerAdapter(SettingsDataAdapter());

  final settingsBox = await Hive.openBox<SettingsData>("settings");
  if (settingsBox.isEmpty) {
    settingsBox.add(SettingsData());
    print("No settings data found, added one");
  }

  GetIt.I.registerSingleton<SettingsData>(settingsBox.getAt(0)!);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setSize(const Size(755, 545));
      await windowManager.setMinimumSize(const Size(350, 600));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }
  runApp(ProviderScope(observers: [Logger()], child: App()));
}
