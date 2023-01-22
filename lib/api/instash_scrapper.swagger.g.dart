// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instash_scrapper.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginStatus _$LoginStatusFromJson(Map<String, dynamic> json) => LoginStatus(
      loggedIn: json['logged_in'] as bool?,
    );

Map<String, dynamic> _$LoginStatusToJson(LoginStatus instance) =>
    <String, dynamic>{
      'logged_in': instance.loggedIn,
    };

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'status': instance.status,
    };

HashtagCheck _$HashtagCheckFromJson(Map<String, dynamic> json) => HashtagCheck(
      id: json['id'] as int?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      name: json['name'] as String?,
      mediaCount: json['media_count'] as int?,
    );

Map<String, dynamic> _$HashtagCheckToJson(HashtagCheck instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time?.toIso8601String(),
      'name': instance.name,
      'media_count': instance.mediaCount,
    };

BaseHashtag _$BaseHashtagFromJson(Map<String, dynamic> json) => BaseHashtag(
      id: json['id'] as int?,
      name: json['name'] as String?,
      mediaCount: json['media_count'] as int?,
    );

Map<String, dynamic> _$BaseHashtagToJson(BaseHashtag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'media_count': instance.mediaCount,
    };

HashtagToCheck _$HashtagToCheckFromJson(Map<String, dynamic> json) =>
    HashtagToCheck(
      id: json['id'] as int?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      name: json['name'] as String?,
      hashtagId: json['hashtag_id'] as String?,
      lastCheck: json['last_check'] == null
          ? null
          : DateTime.parse(json['last_check'] as String),
      mediaCount: json['media_count'] as int?,
    );

Map<String, dynamic> _$HashtagToCheckToJson(HashtagToCheck instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'name': instance.name,
      'hashtag_id': instance.hashtagId,
      'last_check': instance.lastCheck?.toIso8601String(),
      'media_count': instance.mediaCount,
    };
