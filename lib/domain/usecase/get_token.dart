import 'package:flu_warehouse_mobile/domain/auth/token_store.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTokenUseCase {
  GetTokenUseCase({required TokenStore tokenStore}) : _tokenStore = tokenStore;

  final TokenStore _tokenStore;

  Future<String?> call() => _tokenStore.getToken();
}
