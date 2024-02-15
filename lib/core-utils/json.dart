import 'dart:convert';

class Json {
  dynamic decode(String source) {
    try {
      return jsonDecode(source);
    } catch(e) {
      return null;
    }
  }
}
