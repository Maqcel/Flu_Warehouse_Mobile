import 'package:flu_warehouse_mobile/domain/auth/token_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _tokenKey = 'tokenKey';

@Injectable(as: TokenStore)
class TokenSecureStore extends TokenStore {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  @override
  Future<void> initTokenStore() async {
    const String key = 'firstRun';
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool(key) ?? true) {
      await _storage.deleteAll();
      await prefs.setBool(key, false);
    }
  }

  @override
  Future<void> clearToken() => _storage.delete(key: _tokenKey);

  @override
  Future<void> saveToken(String token) => _storage.write(
        key: _tokenKey,
        value: token,
      );

  @override
  Future<String?> getToken() => _storage.read(key: _tokenKey);
}
