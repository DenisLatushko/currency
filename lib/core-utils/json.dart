import 'dart:convert';

///Class to convert JSON string to a data collection defined by this JSON
class Json {
  dynamic decode(String source) {
    try {
      return jsonDecode(source);
    } catch(e) {
      return null;
    }
  }
}
