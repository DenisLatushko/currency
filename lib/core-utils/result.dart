///A base class which presents a result of operation
sealed class Result<S, E> {
  const Result();
}

///A base class which presents a successful result of operation
class Success<S, E> extends Result<S, E> {
  final S data;

  Success(this.data);
}

///A base class which presents a result of operation which is failed
class Error<S, E> extends Result<S, E> {
  final E? error;
  Error(this.error);
}

///Extension functions for [Result] to convert it to a specific subtype
extension ResultExt<S, E> on Result<S, E> {

  Result<R, E> map<R>(R Function(S value) transformation) {
    if(this is Success<S, E>) {
      return Success<R, E>(transformation((this as Success<S, E>).data));
    } else {
      return Error<R, E>((this as Error<S, E>).error);
    }
  }

  Success<S, E> asSuccess() {
    assert(this is Success, 'The current object must be the Success type');
    return this as Success<S, E>;
  }

  Error<S, E> asError() {
    assert(this is Error, 'The current object must be the Error type');
    return this as Error<S, E>;
  }
}
