import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show join;

class DatabaseManager extends GetxService {
  static const String _dbName = 'hipster_prec.db';
  static const int _dbVersion = 1;
  static const String userRecordsDataTable = "user_records";

  static const String idColumn = "id";
  static const String userNameColoum = "userName";
  static const String userEmailColumn = "email";
  static const String userProfilePicColumn = "userProfilePic";
  //just stored mongodb database id, Incase of future use
  static const String databaseID = "databaseId";

  Database? _db;

  initDatabse() async {
    String databsePath = await getDatabasesPath();
    final dbPath = join(databsePath, _dbName);
    _db = await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $userRecordsDataTable (
            $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
            $userNameColoum TEXT NOT NULL,
            $userEmailColumn TEXT NOT NULL,
            $userProfilePicColumn TEXT,
            $databaseID TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>?> getAllSavedData() async {
    if (_db == null) return null;
    return await _db!.query(userRecordsDataTable);
  }

  clearAllData() async {
    await _db?.execute("DELETE FROM $userRecordsDataTable");
  }

  Future<void> saveAllEntries(List<Map<String, dynamic>> data) async {
    await _db?.transaction((txn) async {
      Batch batch = txn.batch();
      for (var record in data) {
        batch.execute(
          "INSERT INTO $userRecordsDataTable ($userNameColoum, $userEmailColumn, $userProfilePicColumn, $databaseID) VALUES (?,?,?,?)",
          [
            record['name'],
            record['email'],
            record['profileImageUrl'],
            record['_id'],
          ],
        );
      }
      await batch.commit(noResult: true);
    });
  }
}
