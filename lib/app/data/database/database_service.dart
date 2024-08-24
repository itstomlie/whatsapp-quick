import 'package:path/path.dart';
import 'package:send_whatsapp/app/data/database/message_db.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initialize();

    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'send_whatsapp.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    return await openDatabase(path,
        version: 1, onCreate: _createDatabase, singleInstance: true);
  }

  Future<void> _createDatabase(Database db, int version) async =>
      await MessageDB().createTable(db);
}
