import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';

final apiUrlProvider = StateNotifierProvider<ApiUrlProvider, String>((ref) => ApiUrlProvider());

class ApiUrlProvider extends StateNotifier<String> {
  ApiUrlProvider() : super("http://localhost:5000");

  update(String uri) {
    state = uri;
  }
}

final apiProvider = Provider((ref) {
  final uri = ref.watch(apiUrlProvider);

  return InstashScrapper.create(baseUrl: Uri.tryParse(uri));
});
