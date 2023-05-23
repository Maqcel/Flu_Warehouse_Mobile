import 'package:flu_warehouse_mobile/domain/usecase/auth/get_token.dart';
import 'package:flu_warehouse_mobile/domain/usecase/auth/init_token_store.dart';
import 'package:flu_warehouse_mobile/domain/usecase/auth/save_token.dart';
import 'package:flu_warehouse_mobile/domain/usecase/user/save_user.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/domain/usecase/login.dart';
import 'package:flu_warehouse_mobile/presentation/pages/login/page/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required InitTokenStoreUseCase initTokenStoreUseCase,
    required GetTokenUseCase getTokenUseCase,
    required SaveTokenUseCase saveTokenUseCase,
    required SaveUserUseCase saveUserUseCase,
    required LoginUseCase loginUseCase,
  })  : _initTokenStoreUseCase = initTokenStoreUseCase,
        _getTokenUseCase = getTokenUseCase,
        _saveTokenUseCase = saveTokenUseCase,
        _saveUserUseCase = saveUserUseCase,
        _loginUseCase = loginUseCase,
        super(const LoginState.init());

  final InitTokenStoreUseCase _initTokenStoreUseCase;
  final GetTokenUseCase _getTokenUseCase;
  final SaveTokenUseCase _saveTokenUseCase;
  final SaveUserUseCase _saveUserUseCase;
  final LoginUseCase _loginUseCase;

  Future<void> init() => _initTokenStoreUseCase().then(
        (_) => _getTokenUseCase().then(
          (token) => emit(
            token != null
                ? const LoginState.success()
                : const LoginState.formState(),
          ),
        ),
      );

  Future<void> loginUser(
    String login,
    String password,
  ) async =>
      state.mapOrNull(
        formState: (currentState) async {
          emit(currentState.copyWith(isLoginInProgress: true));
          (await _loginUseCase(
            password: password,
            login: login,
          ))
              .maybeWhen(
            success: (data) => Future.wait([
              _saveTokenUseCase(data.token),
              _saveUserUseCase(data.userId),
            ]).then(
              (_) => emit(const LoginState.success()),
            ),
            failure: (error) => _handleException(
              currentState,
              error.message,
            ),
            orElse: () => null,
          );
          return;
        },
      );

  void _handleException(LoginState currentState, String? message) {
    emit(LoginState.error(message));
    emit(currentState);
  }
}
