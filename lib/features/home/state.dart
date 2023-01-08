import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loggedOut() = _LoggedOut;
}
