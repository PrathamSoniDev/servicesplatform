class UrlUtils {
  static String designUrl({required String slug}) {
    // Flutter Web → use current origin
    if (Uri.base.hasAuthority) {
      return Uri(
        scheme: Uri.base.scheme,
        host: Uri.base.host,
        port: Uri.base.hasPort ? Uri.base.port : null,
        path: '/design/$slug',
      ).toString();
    }

    // Mobile fallback (Play Store / App Link later)
    return 'https://xyz.com/design/$slug';
  }
}
