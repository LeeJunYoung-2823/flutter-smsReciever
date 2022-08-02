
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sms_reciever/main.dart';
import 'package:sqflite/sqflite.dart';


void main() {

  test('sql test', () async {

    var part = await getDatabasesPath();
    var path = join(part, 'hidden_sms.db');
    final Future<Database> database = openDatabase(path);

  });
}
