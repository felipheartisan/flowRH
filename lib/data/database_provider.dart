import 'dart:io';

import 'package:flow_rh/data/sql.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DatabaseProvider{
  late Database _database;
  Database get database => _database;
  Future<void> open() async {
    sqfliteFfiInit();
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux){
      databaseFactory = databaseFactoryFfi;

      String path = join(await getDatabasesPath(), "flow_rh.db");
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) => _create(db, version));
        
    }
  }

  Future<void> _create(Database db, int version) async{
      await db.execute('PRAGMA foreign_keys = ON');
      return db.execute(Config.sql);
      
  }
}