import 'package:send_whatsapp/app/data/models/message.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MessageDB {
  static Database? _database;
  final String tableName = 'messages';
  final String idColumn = 'id';
  final String numberColumn = 'number';
  final String bodyColumn = 'body';
  final String createdAtColumn = 'created_at';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'messages.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await createTable(db);
      },
    );
  }

  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
        $numberColumn TEXT NOT NULL,
        $bodyColumn TEXT,
        $createdAtColumn DATETIME NOT NULL
      )
    ''');
  }

  Future<int> insertMessage(Message message) async {
    final db = await database;
    return await db.insert(tableName, {
      numberColumn: message.number,
      bodyColumn: message.body,
      createdAtColumn: DateTime.now().toIso8601String(),
    });
  }

  Future<List<Message>> getMessages() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(tableName, orderBy: '$createdAtColumn DESC');
    return maps
        .map((map) => Message(
              map[idColumn] as int,
              map[numberColumn] as String,
              map[bodyColumn] as String?,
              DateTime.parse(map[createdAtColumn] as String),
            ))
        .toList();
  }

  Future<Message> getMessage(int id) async {
    final db = await database;

    final List<Map<String, Object?>> map =
        await db.query(tableName, where: '$idColumn = ?', whereArgs: [id]);
    return Message.fromMap(map.first);
  }

  Future<void> deleteMessage(int id) async {
    final db = await database;

    await db.delete(tableName, where: '$idColumn = ?', whereArgs: [id]);
  }
}
