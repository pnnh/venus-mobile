
import 'dart:io';

import 'package:macos_secure_bookmarks/macos_secure_bookmarks.dart';

class MacOSHelper {
  static final Map<String, String> _bookmarkCache = {};

  static Future<void> macosAccessingSecurityScopedResource(String bookmark) async {
    if (!Platform.isMacOS || bookmark.isEmpty) {
      return;
    }
    if (bookmark.isEmpty || _bookmarkCache.containsKey(bookmark)) return;
    final secureBookmarks = SecureBookmarks();
    final resolvedFile = await secureBookmarks.resolveBookmark(bookmark);

    await secureBookmarks.startAccessingSecurityScopedResource(resolvedFile);
    _bookmarkCache[bookmark] = bookmark;
  }
}