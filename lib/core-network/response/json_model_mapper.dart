abstract class JsonModelMapper<T> {
  T call(Map<String, dynamic> jsonData);
}