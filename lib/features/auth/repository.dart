import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/shared/api/provider.dart';

import 'state.dart';

abstract class AuthRepositoryProtocol {
  Future<AuthState> signIn(String email, String password);

  Future<AuthState> check();
}

final authRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiProvider);
  AuthRepository(client);
});

class AuthRepository implements AuthRepositoryProtocol {
  AuthRepository(this._client);

  final InstashScrapper _client;

  @override
  Future<AuthState> signIn(String username, String password) async {
    return _client
        .loginPost(username: username, password: password)
        .asStream()
        .map((event) => event.isSuccessful && event.body["status"] == true
            ? const AuthState.loggedIn()
            : AuthState.error(event.body))
        .first;
  }

  @override
  Future<AuthState> check() async {
    return _client
        .statusGet()
        .asStream()
        .map((event) => event.isSuccessful && event.body["status"] == true
            ? const AuthState.loggedIn()
            : AuthState.error(event.body))
        .first;
  }
}
