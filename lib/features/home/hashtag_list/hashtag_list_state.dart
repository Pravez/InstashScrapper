import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/shared/loading_state.dart';

part 'hashtag_list_state.freezed.dart';

@freezed
class HashtagListState with _$HashtagListState {
  const factory HashtagListState(
      {@Default([]) List<HashtagToCheck> hashtags,
      @Default(Loading.ok()) Loading loading}) = _HashtagListState;

  const HashtagListState._();
}
