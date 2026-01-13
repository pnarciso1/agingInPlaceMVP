import 'dart:typed_data';

/// A stub for saving files.
Future<void> saveFile(Uint8List bytes, String fileName) async {
  // This will be overridden by the web implementation
  throw UnsupportedError('Cannot save file without a platform implementation');
}
