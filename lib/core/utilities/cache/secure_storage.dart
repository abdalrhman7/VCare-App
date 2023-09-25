import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  var storage = const FlutterSecureStorage();

  void writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?>? readSecureData(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  deleteSecureData(String key) async {
    await storage.delete(key: key);
  }
}
