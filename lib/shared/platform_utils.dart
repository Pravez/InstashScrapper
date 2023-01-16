import 'package:flutter/foundation.dart';

bool get isDesktop {
  if (kIsWeb) return false;

  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

bool get isWindowsDesktop {
  return !kIsWeb &&
      [
        TargetPlatform.windows,
      ].contains(defaultTargetPlatform);
}

bool get isAndroid {
  return !kIsWeb &&
      [
        TargetPlatform.android,
      ].contains(defaultTargetPlatform);
}
