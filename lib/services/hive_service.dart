import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:memento_mori/interfaces/local_db.dart';
import 'package:path_provider/path_provider.dart';

class HiveService implements LocalDB {
  static late Box _box;
  static init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
    _box = await Hive.openBox('stories');
  }

  @override
  int lastId() {
    final keys = _box.keys.toList();
    List<int> intKeys = keys.map((key) => int.tryParse(key.toString()) ?? -1).toList();

    if (intKeys.isEmpty) return 0;
    int id = intKeys.reduce((value, element) => value > element ? value : element);
    return id;
  }

  //TODO precisa retornar list<map<string, dynamic>>
  @override
  Future<List<Map<dynamic, dynamic>>> getAll() async {
    final allValues = _box.toMap().values.cast();
    final filteredValues = allValues.whereType<Map<dynamic, dynamic>>().toList();

    return filteredValues;
  }

  @override
  Future<List<Map<dynamic, dynamic>>> getByCategory(String category) async {
    final allValues = _box.toMap().values.toList();
    final filteredValues = allValues.whereType<Map<dynamic, dynamic>>().where((element) => element['category'] == category).toList();
    return filteredValues;
  }

  @override
  Future<List<Map<dynamic, dynamic>>> getFavorites() async {
    final allValues = _box.toMap().values.toList();
    final filteredValues = allValues.whereType<Map<dynamic, dynamic>>().where((element) => element['favorite'] == true).toList();
    return filteredValues;
  }

  @override
  Future<void> save(String key, Map<String, dynamic> value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> delete(String key) async {
    await _box.delete(key);
  }
}
