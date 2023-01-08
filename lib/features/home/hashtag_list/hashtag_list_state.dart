import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instash_scrapper/api/instash_scrapper.swagger.dart';
import 'package:instash_scrapper/shared/app_exception.dart';

part 'hashtag_list_state.freezed.dart';

@freezed
class HashtagListState with _$HashtagListState {
  const factory HashtagListState.loading() = HashtagListLoading;

  const factory HashtagListState.done(List<HashtagToCheck> hashtags) = HashtagListDone;

  const factory HashtagListState.error(AppException error) = HashtagListStateError;
}
