import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = _Initial;

  const factory AppState.unauthenticated() = Unauthenticated;

  const factory AppState.internetUnAvailable() = _InternetUnAvailable;

  const factory AppState.authenticated() = AppAuthenticated;
}
