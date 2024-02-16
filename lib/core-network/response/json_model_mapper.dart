///A base type for any JSON mapper to be called during the HTTP response
///processing flow
abstract class JsonModelMapper<T> {
  T call(Map<String, dynamic> jsonData);
}
