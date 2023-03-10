import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/app/router.dart';
import 'package:instash_scrapper/shared/app_exception.dart';

import 'repository.dart';
import 'state.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return AuthProvider(authRepository);
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(this._authRepository) : super(const AuthState.initial()) {
    check();
  }

  final AuthRepository _authRepository;



  Future<AppException?> signIn(String email, String password) async {
    state = const AuthState.loading();

    return _authRepository.signIn(email, password).then((value) {
      state = value;

      return value.maybeWhen(
          error: (err) => Future.error(err), orElse: () => Future.value(null));
    });
  }

  check() async {
    state = const AuthState.loading();
    state = await _authRepository.check();
  }

  canReachServer() async {
    state = const AuthState.loading();
    state = await _authRepository.canReachServer();
  }
}
