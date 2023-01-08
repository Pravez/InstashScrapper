import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';
import 'repository.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return AuthProvider(authRepository);
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(this._authRepository) : super(const AuthState.initial());

  final AuthRepository _authRepository;

  Future<void> signIn(String email, String password) async {
    state = await _authRepository.signIn(email, password);
  }

  Future<void> check() async {
    state = await _authRepository.check();
  }
}
