import 'package:flu_warehouse_mobile/domain/user/user_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

const String _userKey = 'userKey';

@Injectable(as: UserService)
class UserServiceImpl extends UserService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  @override
  Future<void> clearUser() => _storage.delete(key: _userKey);

  @override
  Future<String?> getUser() => _storage.read(key: _userKey);

  @override
  Future<void> saveUser(String userId) => _storage.write(
        key: _userKey,
        value: userId,
      );
}
