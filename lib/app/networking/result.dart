import 'package:equatable/equatable.dart';
import 'package:flu_warehouse_mobile/app/networking/failure.dart';

/// Based on Either Class type
abstract class Result<S> extends Equatable {
  static Result<S> failure<S>(Failure failure) => _FailureResult(failure);

  static Result<S> success<S>(S data) => _SuccessResult(data);

  Failure? get error => fold<Failure?>((data) => null, (error) => error);

  S? get data => fold<S?>((data) => data, (error) => null);

  bool get isSuccess => this is _SuccessResult<S>;

  bool get isFailure => this is _FailureResult<S>;

  S dataOrElse(S other) => (isSuccess && data != null) ? data! : other;

  Result<T> then<T>(Result<T> Function(S data) function);

  Result<T> map<T>(T Function(S data) function);

  Result<T> either<T>(
    T Function(S data) success,
    Failure Function(Failure error) failure,
  );

  T fold<T>(
    T Function(S data) success,
    T Function(Failure error) failure,
  );

  @override
  List<Object?> get props => [if (isSuccess) data else error];
}

class _SuccessResult<S> extends Result<S> {
  _SuccessResult(this._value);

  final S _value;

  @override
  Result<T> then<T>(Result<T> Function(S data) function) => function(_value);

  @override
  _SuccessResult<T> map<T>(T Function(S data) function) =>
      _SuccessResult<T>(function(_value));

  @override
  _SuccessResult<T> either<T>(
    T Function(S data) success,
    Failure Function(Failure error) failure,
  ) =>
      _SuccessResult<T>(success(_value));

  @override
  T fold<T>(
    T Function(S data) success,
    T Function(Failure error) failure,
  ) =>
      success(_value);

  @override
  List<Object?> get props => [_value];
}

class _FailureResult<S> extends Result<S> {
  _FailureResult(this._value);

  final Failure _value;

  @override
  _FailureResult<T> map<T>(T Function(S data) function) =>
      _FailureResult<T>(_value);

  @override
  _FailureResult<T> then<T>(Result<T> Function(S data) function) =>
      _FailureResult<T>(_value);

  @override
  _FailureResult<T> either<T>(
    T Function(S data) success,
    Failure Function(Failure error) failure,
  ) =>
      _FailureResult<T>(failure(_value));

  @override
  T fold<T>(
    T Function(S data) success,
    T Function(Failure error) failure,
  ) =>
      failure(_value);

  @override
  List<Object?> get props => [_value];
}
