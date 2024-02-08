
import 'package:hiring_test/core/util/app_constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDataBase {

  LocalDataBase._();

  static Database ? database ;

  static Future<Database> getDataBase() async{
    await Permission.storage.request();
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'data.db');
    database ??= await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            await db.execute(
                'CREATE TABLE ${AppConstants.itemsTable} ( id INTEGER PRIMARY KEY, full_name TEXT,description TEXT, url TEXT )');
            await db.execute(
                'CREATE TABLE ${AppConstants.itemsInfoTable} ( id INTEGER PRIMARY KEY,description TEXT, full_name TEXT, watchers INTEGER,forks_count INTEGER,'
                    'subscribers_count INTEGER, url TEXT, created_at TEXT, updated_at TEXT )'
            );
          });
    return database! ;
  }
}