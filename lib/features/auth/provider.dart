import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instash_scrapper/shared/app_exception.dart';

import 'repository.dart';
import 'state.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return AuthProvider(authRepository);
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(this._authRepository) : super(const AuthState.initial());

  final AuthRepository _authRepository;

  Future<AppException?> signIn(String email, String password) async {
    state = const AuthState.loading();

    return _authRepository.signIn(email, password).then((value) {
      state = value;

      return value.maybeWhen(
          error: (err) => Future.error(err), orElse: () => Future.value(null));
    });
  }

  ignoreSignIn() {
    state = const AuthState.notLoggedIn();
  }

  check() async {
    state = await _authRepository.check();
  }
}
