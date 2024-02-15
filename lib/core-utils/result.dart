sealed class Result<S, E> {
  const Result();
}

class Success<S, E> extends Result<S, E> {
  final S data;

  Success(this.data);
}

class Error<S, E> extends Result<S, E> {
  final E? error;
  Error(this.error);
}

extension ResultExt<S, E> on Result<S, E> {
  Success<S, E> asSuccess() {
    assert(this is Success, 'The current object must be the Success type');
    return this as Success<S, E>;
  }

  Error<S, E> asError() {
    assert(this is Error, 'The current object must be the Error type');
    return this as Error<S, E>;
  }
}