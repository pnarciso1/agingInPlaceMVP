import 'dart:typed_data';

Future<void> saveFile(Uint8List bytes, String fileName) async {
  // Mobile uses Printing.sharePdf directly in the dashboard, 
  // so this implementation won't be called, but we need it to satisfy the compiler.
}
