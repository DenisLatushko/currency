import 'package:mockito/mockito.dart';

///A stub of a functional type which has one parameter [P] and return [T]
class Function1<T, P> extends Mock {
  T call(P? param);
}
