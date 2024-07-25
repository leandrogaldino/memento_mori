import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteService {
  SqfliteService._();

  static final instance = SqfliteService._();

  static Database? _database;

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'stories.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(_storiesCreateTable);
  }
}
