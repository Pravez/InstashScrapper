// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:chopper/chopper.dart' as chopper;

part 'instash_scrapper.swagger.chopper.dart';
part 'instash_scrapper.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class InstashScrapper extends ChopperService {
  static InstashScrapper create({
    ChopperClient? client,
    Authenticator? authenticator,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$InstashScrapper(client);
    }

    final newClient = ChopperClient(
        services: [_$InstashScrapper()],
        converter: $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        authenticator: authenticator,
        baseUrl: baseUrl ?? Uri.parse('http:///'));
    return _$InstashScrapper(newClient);
  }

  ///
  ///@param X-Fields An optional fields mask
  Future<chopper.Response<List<HashtagToCheck>>> checksGet({String? xFields}) {
    generatedMapping.putIfAbsent(
        HashtagToCheck, () => HashtagToCheck.fromJsonFactory);

    return _checksGet(xFields: xFields);
  }

  ///
  ///@param X-Fields An optional fields mask
  @Get(path: '/checks')
  Future<chopper.Response<List<HashtagToCheck>>> _checksGet(
      {@Header('X-Fields') String? xFields});

  ///
  ///@param X-Fields An optional fields mask
  Future<chopper.Response<HashtagToCheck>> checksNameGet({
    String? xFields,
    required String? name,
  }) {
    generatedMapping.putIfAbsent(
        HashtagToCheck, () => HashtagToCheck.fromJsonFactory);

    return _checksNameGet(xFields: xFields, name: name);
  }

  ///
  ///@param X-Fields An optional fields mask
  @Get(path: '/checks/{name}')
  Future<chopper.Response<HashtagToCheck>> _checksNameGet({
    @Header('X-Fields') String? xFields,
    @Path('name') required String? name,
  });

  ///
  ///@param X-Fields An optional fields mask
  Future<chopper.Response<HashtagToCheck>> checksNamePost({
    String? xFields,
    required String? name,
  }) {
    generatedMapping.putIfAbsent(
        HashtagToCheck, () => HashtagToCheck.fromJsonFactory);

    return _checksNamePost(xFields: xFields, name: name);
  }

  ///
  ///@param X-Fields An optional fields mask
  @Post(
    path: '/checks/{name}',
    optionalBody: true,
  )
  Future<chopper.Response<HashtagToCheck>> _checksNamePost({
    @Header('X-Fields') String? xFields,
    @Path('name') required String? name,
  });

  ///
  ///@param X-Fields An optional fields mask
  Future<chopper.Response<HashtagCheck>> hashtagsNameGet({
    String? xFields,
    required String? name,
  }) {
    generatedMapping.putIfAbsent(
        HashtagCheck, () => HashtagCheck.fromJsonFactory);

    return _hashtagsNameGet(xFields: xFields, name: name);
  }

  ///
  ///@param X-Fields An optional fields mask
  @Get(path: '/hashtags/{name}')
  Future<chopper.Response<HashtagCheck>> _hashtagsNameGet({
    @Header('X-Fields') String? xFields,
    @Path('name') required String? name,
  });

  ///
  Future<chopper.Response> loginPost() {
    return _loginPost();
  }

  ///
  @Post(
    path: '/login',
    optionalBody: true,
  )
  Future<chopper.Response> _loginPost();

  ///
  Future<chopper.Response> statusGet() {
    return _statusGet();
  }

  ///
  @Get(path: '/status')
  Future<chopper.Response> _statusGet();
}

@JsonSerializable(explicitToJson: true)
class HashtagCheck {
  HashtagCheck({
    this.id,
    this.time,
    this.name,
    this.mediaCount,
  });

  factory HashtagCheck.fromJson(Map<String, dynamic> json) =>
      _$HashtagCheckFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'time')
  final DateTime? time;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'media_count')
  final int? mediaCount;
  static const fromJsonFactory = _$HashtagCheckFromJson;
  static const toJsonFactory = _$HashtagCheckToJson;
  Map<String, dynamic> toJson() => _$HashtagCheckToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HashtagCheck &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.mediaCount, mediaCount) ||
                const DeepCollectionEquality()
                    .equals(other.mediaCount, mediaCount)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(mediaCount) ^
      runtimeType.hashCode;
}

extension $HashtagCheckExtension on HashtagCheck {
  HashtagCheck copyWith(
      {int? id, DateTime? time, String? name, int? mediaCount}) {
    return HashtagCheck(
        id: id ?? this.id,
        time: time ?? this.time,
        name: name ?? this.name,
        mediaCount: mediaCount ?? this.mediaCount);
  }

  HashtagCheck copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<DateTime?>? time,
      Wrapped<String?>? name,
      Wrapped<int?>? mediaCount}) {
    return HashtagCheck(
        id: (id != null ? id.value : this.id),
        time: (time != null ? time.value : this.time),
        name: (name != null ? name.value : this.name),
        mediaCount: (mediaCount != null ? mediaCount.value : this.mediaCount));
  }
}

@JsonSerializable(explicitToJson: true)
class HashtagToCheck {
  HashtagToCheck({
    this.id,
    this.created,
    this.name,
    this.hashtagId,
    this.lastCheck,
    this.mediaCount,
  });

  factory HashtagToCheck.fromJson(Map<String, dynamic> json) =>
      _$HashtagToCheckFromJson(json);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'created')
  final DateTime? created;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'hashtag_id')
  final String? hashtagId;
  @JsonKey(name: 'last_check')
  final DateTime? lastCheck;
  @JsonKey(name: 'media_count')
  final int? mediaCount;
  static const fromJsonFactory = _$HashtagToCheckFromJson;
  static const toJsonFactory = _$HashtagToCheckToJson;
  Map<String, dynamic> toJson() => _$HashtagToCheckToJson(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HashtagToCheck &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.created, created) ||
                const DeepCollectionEquality()
                    .equals(other.created, created)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.hashtagId, hashtagId) ||
                const DeepCollectionEquality()
                    .equals(other.hashtagId, hashtagId)) &&
            (identical(other.lastCheck, lastCheck) ||
                const DeepCollectionEquality()
                    .equals(other.lastCheck, lastCheck)) &&
            (identical(other.mediaCount, mediaCount) ||
                const DeepCollectionEquality()
                    .equals(other.mediaCount, mediaCount)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(created) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(hashtagId) ^
      const DeepCollectionEquality().hash(lastCheck) ^
      const DeepCollectionEquality().hash(mediaCount) ^
      runtimeType.hashCode;
}

extension $HashtagToCheckExtension on HashtagToCheck {
  HashtagToCheck copyWith(
      {int? id,
      DateTime? created,
      String? name,
      String? hashtagId,
      DateTime? lastCheck,
      int? mediaCount}) {
    return HashtagToCheck(
        id: id ?? this.id,
        created: created ?? this.created,
        name: name ?? this.name,
        hashtagId: hashtagId ?? this.hashtagId,
        lastCheck: lastCheck ?? this.lastCheck,
        mediaCount: mediaCount ?? this.mediaCount);
  }

  HashtagToCheck copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<DateTime?>? created,
      Wrapped<String?>? name,
      Wrapped<String?>? hashtagId,
      Wrapped<DateTime?>? lastCheck,
      Wrapped<int?>? mediaCount}) {
    return HashtagToCheck(
        id: (id != null ? id.value : this.id),
        created: (created != null ? created.value : this.created),
        name: (name != null ? name.value : this.name),
        hashtagId: (hashtagId != null ? hashtagId.value : this.hashtagId),
        lastCheck: (lastCheck != null ? lastCheck.value : this.lastCheck),
        mediaCount: (mediaCount != null ? mediaCount.value : this.mediaCount));
  }
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
