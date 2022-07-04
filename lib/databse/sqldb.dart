import 'dart:math';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  //-------------Intialize database---------------------
  initDb() async {
    String databsepath = await getDatabasesPath();
    String path = join(databsepath, 'islam.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("Update Database and Table ===============");
  }

  //----------------Creating Database-------------------
  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
    CREATE TABLE "users" (
      "id" INTEGER  NOT NULL  PRIMARY KEY  AUTOINCREMENT,
      "name" TEXT NOT NULL,
      "email" TEXT NOT NULL,
      "password" TEXT NOT NULL,
      "birthdate" TEXT NOT NULL
    )
    ''');

    batch.execute('''
    CREATE TABLE "alphabets" (
      "id" INTEGER  NOT NULL  PRIMARY KEY  AUTOINCREMENT,
      "alpha" TEXT NOT NULL,
      "word" TEXT NOT NULL      
    )
    ''');

    batch.rawInsert('''
    INSERT INTO 'users' ('email' ,'name' ,'password','birthdate') 
    VALUES ("ahmad@gmail.com" , "ahmad" , "123456" , "1999")
    ''');

    batch.insert("alphabets", {
      "alpha": "أ",
      "word": "احمد",
    });

    batch.insert("alphabets", {
      "alpha": "ب",
      "word": "بطاقة",
    });

    batch.insert("alphabets", {
      "alpha": "ت",
      "word": "تفاح",
    });

    batch.insert("alphabets", {
      "alpha": "ث",
      "word": "ثوب",
    });

    batch.insert("alphabets", {
      "alpha": "ج",
      "word": "جائزة",
    });

    batch.insert("alphabets", {
      "alpha": "ح",
      "word": "حبار",
    });

    batch.insert("alphabets", {
      "alpha": "خ",
      "word": "خباز",
    });

    batch.insert("alphabets", {
      "alpha": "د",
      "word": "دمية",
    });

    await batch.commit();
    print("Create Database and Table ===============");
  }

  //--------------------SQL Functions CRUL (raw)-------------------

  //Select Data
  readDate(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  //INSERT Data
  insertDate(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  //Update Data
  updateDate(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  //Delete Data
  deleteDate(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  //Delete the hole database
  deleteHoleDatabase() async {
    String databsepath = await getDatabasesPath();
    String path = join(databsepath, 'islam.db');
    await deleteDatabase(path);
  }

  // ------------------SQL functions CURL----------------------
//Select Data
  read(String table) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  //INSERT Data
  insert(String table, Map<String, Object?> values) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table, values);
    return response;
  }

  //Update Data
  update(String table, Map<String, Object?> values, String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.update(table, values, where: myWhere);
    return response;
  }

  //Delete Data
  delete(String table, String? myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.delete(table, where: myWhere);
    return response;
  }
}
