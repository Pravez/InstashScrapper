import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_state.freezed.dart';

@freezed
class Loading with _$Loading {
  const factory Loading.loading() = LoadingState;
  const factory Loading.ok() = OkState;
  const factory Loading.error(Object? error) = ErrorState;
}
