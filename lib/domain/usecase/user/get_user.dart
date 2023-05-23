import 'package:flu_warehouse_mobile/domain/user/user_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserUseCase {
  GetUserUseCase({required UserService userStore}) : _userStore = userStore;

  final UserService _userStore;

  Future<String?> call() => _userStore.getUser();
}
