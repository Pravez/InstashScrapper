import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';

final apiUrlProvider = StateNotifierProvider<ApiUrl, String>((ref) => ApiUrl());

class ApiUrl extends StateNotifier<String> {
  ApiUrl() : super("http://localhost:5000");

  update(String uri) {
    state = uri;
  }
}

final apiProvider = Provider((ref) {
  final uri = ref.watch(apiUrlProvider);

  return InstashScrapper.create(baseUrl: Uri.tryParse(uri));
});
