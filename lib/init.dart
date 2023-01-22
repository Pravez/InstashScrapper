import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:instash_scrapper/features/settings/settings_data.dart';
import 'package:instash_scrapper/shared/platform_utils.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

Future<void> init() async {
  FlutterCryptography.enable();
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

Future<void> initWindow() async {
  if (isAndroid || isWindowsDesktop) {
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
      await windowManager.setSize(const Size(1200, 1000));
      await windowManager.setMinimumSize(const Size(350, 600));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }
}
