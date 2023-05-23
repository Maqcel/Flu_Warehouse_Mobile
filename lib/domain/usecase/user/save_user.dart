import 'package:flu_warehouse_mobile/domain/user/user_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveUserUseCase {
  SaveUserUseCase({required UserService userStore}) : _userStore = userStore;

  final UserService _userStore;

  Future<void> call(String userId) => _userStore.saveUser(userId);
}
