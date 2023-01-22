import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/shared/api_provider.dart';
import 'package:instash_scrapper/shared/app_exception.dart';

import 'state.dart';

abstract class AuthRepositoryProtocol {
  Future<AuthState> signIn(String email, String password);

  Future<AuthState> check();
}

final authRepositoryProvider = Provider((ref) {
  final client = ref.watch(apiProvider);

  return AuthRepository(client);
});

class AuthRepository implements AuthRepositoryProtocol {
  AuthRepository(this._client);

  final InstashScrapper _client;

  @override
  Future<AuthState> signIn(String username, String password) async {
    return _client
        .loginPost(payload: {"username": username, "password": password})
        .asStream()
        .map((event) => event.isSuccessful && event.body!.status!
            ? const AuthState.loggedIn()
            : const AuthState.error(AppException.unauthorized()))
        .first;
  }

  @override
  Future<AuthState> check() async {
      return _client
          .statusGet()
          .asStream()
          .map((event) =>
      event.isSuccessful && event.body!.loggedIn!
          ? const AuthState.loggedIn()
          : const AuthState.error(AppException.unauthorized()))
          .first
      .catchError((error) {
        return AuthState.error(AppException.errorWithMessage(error.toString()));
      });
  }
}
