import 'dart:io' show Platform, stdout;

String homeDirectory() {
  switch (Platform.operatingSystem) {
    case 'linux':
    case 'macos':
      return Platform.environment['HOME'] ?? "";
    case 'windows':
      return Platform.environment['USERPROFILE'] ?? "";
    case 'android':
      // Probably want internal storage.
      return '/storage/sdcard0';
    case 'ios':
      // iOS doesn't really have a home directory.
      return "";
    case 'fuchsia':
      // I have no idea.
      return "";
    default:
      return "";
  }
}

String lookupPath(String path) {
  var homePath = homeDirectory();
  if (path == "~") return homePath;

  return path.replaceFirst("~/", homePath);
}
