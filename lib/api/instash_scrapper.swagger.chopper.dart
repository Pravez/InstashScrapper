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
    String? xFields,
    required String? name,
  }) {
    final Uri $url = Uri.parse('/hashtags/${name}');
    final Map<String, String> $headers = {
      if (xFields != null) 'X-Fields': xFields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
    );
    return client.send<HashtagCheck, HashtagCheck>($request);
  }

  @override
  Future<Response<dynamic>> _loginPost() {
    final Uri $url = Uri.parse('/login');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _statusGet() {
    final Uri $url = Uri.parse('/status');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
