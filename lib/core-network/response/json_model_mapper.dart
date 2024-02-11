abstract interface class JsonModelMapper<T> {
  T call(String json);
}