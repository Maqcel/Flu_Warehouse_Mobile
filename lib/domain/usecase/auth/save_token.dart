import 'package:flu_warehouse_mobile/domain/auth/token_store.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveTokenUseCase {
  SaveTokenUseCase({required TokenStore tokenStore}) : _tokenStore = tokenStore;

  final TokenStore _tokenStore;

  Future<void> call(String token) => _tokenStore.saveToken(token);
}
