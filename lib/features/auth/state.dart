import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instash_scrapper/shared/app_exception.dart';

part 'state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.loggedIn() = AuthLoggedIn;
  const factory AuthState.notLoggedIn() = AuthNotLoggedIn;
  const factory AuthState.error(AppException error) = _Error;
}
