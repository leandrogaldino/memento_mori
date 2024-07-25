import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:memento_mori/interfaces/local_db.dart';

class SqfliteService implements LocalDB {
  SqfliteService._();

  static final instance = SqfliteService._();

  static late final Database _database;

  @override
  Future<int> getLastId({required String table}) async {
    var result = await _database.query(table, columns: ['id'], orderBy: 'id DESC', limit: 1);
    if (result.isNotEmpty) {
      return result.first['id'] as int;
    }
    return 0;
  }

  @override
  Future<void> delete(String table, {String? where, List<Object?>? whereArgs}) async {
    await _database.delete(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<int> save(String table, Map<String, Object?> values) async {
    if (values['id'] == 0) {
      return await _database.insert(table, values);
    } else {
      await _database.update(table, values, where: 'id=${values['id']}');
      return int.parse(values['id'].toString());
    }
  }

  @override
  Future<List<Map<String, Object?>>> get(String table, {List<String>? columns, String? where, List<Object?>? whereArgs, String? orderBy}) async {
    return await _database.query(table, columns: columns, where: where, whereArgs: whereArgs, orderBy: orderBy);
  }

  static initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'stories.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  static _onCreate(Database db, int version) async {
    await db.execute(_storiesCreateTable);
  }

//TODO criar estrutura do banco;
  static String get _storiesCreateTable => '';
}
