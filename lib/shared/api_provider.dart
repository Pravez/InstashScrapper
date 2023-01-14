import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/features/settings/provider.dart';

final apiProvider = Provider((ref) {
  final settings = ref.watch(settingsProvider);

  return InstashScrapper.create(baseUrl: Uri.tryParse(settings.serverAddress));
});
