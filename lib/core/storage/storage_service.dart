import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _boxName = 'app_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
    // TODO: register Hive adapters here
  }

  static Box get _box => Hive.box(_boxName);

  static Future<void> put(String key, dynamic value) async =>
      _box.put(key, value);

  static T? get<T>(String key) => _box.get(key) as T?;

  static Future<void> delete(String key) async => _box.delete(key);

  static Future<void> clear() async => _box.clear();
}
