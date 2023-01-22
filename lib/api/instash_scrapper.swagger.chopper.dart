// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instash_scrapper.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$InstashScrapper extends InstashScrapper {
  _$InstashScrapper([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = InstashScrapper;

  @override
  Future<Response<List<HashtagToCheck>>> _checksGet({String? xFields}) {
    final Uri $url = Uri.parse('/checks');
    final Map<String, String> $headers = {
      if (xFields != null) 'X-Fields': xFields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<HashtagToCheck>, HashtagToCheck>($request);
  }

  @override
  Future<Response<HashtagToCheck>> _checksNameGet({
    String? xFields,
    required String? name,
  }) {
    final Uri $url = Uri.parse('/checks/${name}');
    final Map<String, String> $headers = {
      if (xFields != null) 'X-Fields': xFields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<HashtagToCheck, HashtagToCheck>($request);
  }

  @override
  Future<Response<HashtagToCheck>> _checksNamePost({
    String? xFields,
    required String? name,
  }) {
    final Uri $url = Uri.parse('/checks/${name}');
    final Map<String, String> $headers = {
      if (xFields != null) 'X-Fields': xFields,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<HashtagToCheck, HashtagToCheck>($request);
  }

  @override
  Future<Response<HashtagCheck>> _hashtagsNameGet({
    bool? refresh,
    String? xFields,
    required String? name,
  }) {
    final Uri $url = Uri.parse('/hashtags/${name}');
    final Map<String, dynamic> $params = <String, dynamic>{'refresh': refresh};
    final Map<String, String> $headers = {
      if (xFields != null) 'X-Fields': xFields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
    );
    return client.send<HashtagCheck, HashtagCheck>($request);
  }

  @override
  Future<Response<List<HashtagCheck>>> _hashtagsNameHistoryGet({
    String? xFields,
    required String? name,
  }) {
    final Uri $url = Uri.parse('/hashtags/${name}/history');
    final Map<String, String> $headers = {
      if (xFields != null) 'X-Fields': xFields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<HashtagCheck>, HashtagCheck>($request);
  }

  @override
  Future<Response<List<BaseHashtag>>> _hashtagsNameRelatedGet({
    String? xFields,
    required String? name,
  }) {
    final Uri $url = Uri.parse('/hashtags/${name}/related');
    final Map<String, String> $headers = {
      if (xFields != null) 'X-Fields': xFields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<List<BaseHashtag>, BaseHashtag>($request);
  }

  @override
  Future<Response<LoginResult>> _loginPost({
    required Object? payload,
    String? xFields,
  }) {
    final Uri $url = Uri.parse('/login');
    final Map<String, String> $headers = {
      if (xFields != null) 'X-Fields': xFields,
    };
    final $body = payload;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<LoginResult, LoginResult>($request);
  }

  @override
  Future<Response<LoginStatus>> _statusGet({String? xFields}) {
    final Uri $url = Uri.parse('/status');
    final Map<String, String> $headers = {
      if (xFields != null) 'X-Fields': xFields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<LoginStatus, LoginStatus>($request);
  }
}
