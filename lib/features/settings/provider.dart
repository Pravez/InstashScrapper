import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/features/settings/settings_data.dart';

final settingsProvider = StateProvider((ref) => GetIt.I.get<SettingsData>());
