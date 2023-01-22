import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';

part 'state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.data(List<HashtagCheck> data) = _Data;
}
