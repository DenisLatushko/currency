import 'dart:convert';

class Json {
  dynamic decode(String source) {
    try {
      return json.decode(source);
    } catch(e) {
      return null;
    }
  }
}
