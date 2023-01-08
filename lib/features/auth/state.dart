import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instash_scrapper/shared/app_exception.dart';

part 'state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.loggedIn() = _LoggedIn;
  const factory AuthState.error(AppException error) = _Error;
}
