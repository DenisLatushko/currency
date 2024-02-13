import 'dart:convert';
import 'dart:io';

/// Read file by provided [filePath]
/// If the file does not exist then throw [PathAccessException]
String readFile(String filePath) {
  final file = File(filePath);
  if (file.existsSync()) {
    return file.readAsStringSync();
  }

  throw PathAccessException(filePath, const OSError());
}

Map<String, dynamic> readJsonFromFile(String filePath) {
  return Map.unmodifiable(jsonDecode(readFile(filePath)));
}
