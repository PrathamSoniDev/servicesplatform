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

    // Control behavior
    bool shareAsPureLink = false, // 🔑 IMPORTANT
  }) async {
    assert(
      url.startsWith('http'),
      'URL must be a valid absolute HTTP/HTTPS URL',
    );

    /// ─────────────────────────────────────────────
    /// MODE 1: PURE LINK (NO TEXT)
    /// ─────────────────────────────────────────────
    if (shareAsPureLink) {
      await SharePlus.instance.share(
        ShareParams(
          uri: Uri.parse(url),
          subject: subject ?? title,
          sharePositionOrigin: sharePositionOrigin,
          downloadFallbackEnabled: downloadFallbackEnabled,
          mailToFallbackEnabled: mailToFallbackEnabled,
          excludedCupertinoActivities: excludedCupertinoActivities,
        ),
      );
      return;
    }

    /// ─────────────────────────────────────────────
    /// MODE 2: TEXT SHARE (RECOMMENDED)
    /// ─────────────────────────────────────────────
    final textContent = [
      title,
      if (description.isNotEmpty) '',
      if (description.isNotEmpty) description,
      '',
      url,
    ].join('\n');

    await SharePlus.instance.share(
      ShareParams(
        title: title,
        subject: subject ?? title,
        text: textContent,

        // Rich preview (platform dependent)
        previewThumbnail: previewThumbnail,

        // File sharing (optional)
        files: files,
        fileNameOverrides: fileNameOverrides,

        // iPad / Desktop positioning
        sharePositionOrigin: sharePositionOrigin,

        // Platform fallbacks
        downloadFallbackEnabled: downloadFallbackEnabled,
        mailToFallbackEnabled: mailToFallbackEnabled,

        // iOS exclusions
        excludedCupertinoActivities: excludedCupertinoActivities,
      ),
    );
  }
}
