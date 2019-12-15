
import 'package:otobill/model/defaultLocations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DbHelper {
  String tblLocation = "Location";
  String latitude = "latitude";
  String longitude = "longitude";
  static final DbHelper _dbHelper = DbHelper._internal();
  DbHelper._internal();
  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDB();
    }
    return _db;
  }

  Future<Database> initializeDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "OTOBILL.db";

    var dbEtrade = await openDatabase(path, version: 1, onCreate: _craeteDB);
    return dbEtrade;
  }

  void _craeteDB(Database db, int version) async {
    // await db.execute(
    //     "Create Table $tblUser($phoneno text,$name text,$surname text,$latitude text,$longitude text);Create Table $tblRoadMap($yolculukId text,$surucuId text,$latitude text,$longitude text)");
    await db.execute(
        '''create table $tblLocation ($latitude text,$longitude text)''');            
  }

  Future<int> insert(DefaultLocations locations) async {
    Database db = await this.db;
    var result = await db.insert(tblLocation,locations.toMap());
    return result;
  }

  Future<int> update(DefaultLocations locations) async {
    Database db = await this.db;
    var result = await db.update(tblLocation, locations.toMap());
    return result;
  }

  Future<int> delete() async {
    Database db = await this.db;
    var result = await db.rawDelete("Delete From $tblLocation");
    return result;
  }


}