import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sms/sms.dart';
import 'package:sms_reciever/models/sms_model.dart';
import 'package:sqflite/sqflite.dart';

final String TableName = 'Hidden_sms';

/// 내부 DB
class DBHelper {
  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'SmsReciever.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TableName (smsdate TEXT NOT NULL PRIMARY KEY,
          id INTEGER NOT NULL, date TEXT NOT NULL, name TEXT NOT NULL,
          totalmoney TEXT NOT NULL, deletedate TEXT NOT NULL)
          ''');
      },
    );
  }

  // 업로드 문자 Insert Query (업로드)
  insertData(SmsMessage hidden) async {
    final db = await database;
    var result = await db.rawInsert(
        "INSERT INTO $TableName(id, date, name, totalmoney, deletedate, smsdate)"
        " VALUES (${hidden.id},'${getSMSValue(hidden.body, 1).replaceAll('[KB]', '')}',"
        " '${getSMSValue(hidden.body, 3)}', '${getSMSValue(hidden.body, 5)}', datetime('now','localtime'),"
        " '${hidden.date}')");
    return result;
  }

  // 업로드 문자 Select Query
  Future<List<DBSms>> selectData() async {
    final db = await database;
    var result = await db.rawQuery("SELECT * FROM $TableName");

    List<DBSms> list = result.isNotEmpty
        ? result
            .map((element) => DBSms(date: DateTime.parse(element['smsdate'])))
            .toList()
        : [];

    return list;
  }
}
