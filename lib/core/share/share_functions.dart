import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

class ShareFunctions {
  Future<void> shareLink({
    required String title,
    required String description,
    required String url,

    // Optional / advanced params
    String? subject,
    XFile? previewThumbnail,
    Rect? sharePositionOrigin,
    List<XFile>? files,
    List<String>? fileNameOverrides,
    bool downloadFallbackEnabled = true,
    bool mailToFallbackEnabled = true,
    List<CupertinoActivityType>? excludedCupertinoActivities,
  }) async {
    assert(
      url.startsWith('http'),
      'URL must be a valid absolute HTTP/HTTPS URL',
    );

    final textContent = '''
$title

$description

$url
''';

    await SharePlus.instance.share(
      ShareParams(
        // Core content
        title: title,
        subject: subject ?? title,
        text: textContent,
        uri: Uri.parse(url),

        // Rich preview (supported platforms only)
        previewThumbnail: previewThumbnail,

        // File sharing (optional)
        files: files,
        fileNameOverrides: fileNameOverrides,

        // iPad / Desktop positioning
        sharePositionOrigin: sharePositionOrigin,

        // Platform fallbacks
        downloadFallbackEnabled: downloadFallbackEnabled,
        mailToFallbackEnabled: mailToFallbackEnabled,

        // iOS-specific exclusions
        excludedCupertinoActivities: excludedCupertinoActivities,
      ),
    );
  }
}
