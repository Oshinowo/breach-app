import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static setUserToken(String userToken) async {
    await _storage.write(key: 'userToken', value: userToken);
  }

  static Future<String?> readUserToken() async {
    var readData = await _storage.read(key: 'userToken');
    return readData;
  }

  static deleteUserToken() async {
    await _storage.delete(key: 'userToken');
  }

  static setUserId(String userId) async {
    await _storage.write(key: 'userId', value: userId);
  }

  static Future<String?> readUserId() async {
    var readData = await _storage.read(key: 'userId');
    return readData;
  }

  static deleteUserId() async {
    await _storage.delete(key: 'userId');
  }
}
