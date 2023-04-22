import 'package:flu_warehouse_mobile/presentation/pages/login/domain/model/login.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.init() = LoginStateInit;

  const factory LoginState.formState({
    @Default(false) bool isLoginInProgress,
  }) = LoginStateLoaded;

  const factory LoginState.success() = LoginStateSuccess;

  const factory LoginState.error([String? message]) = LoginStateError;
}
