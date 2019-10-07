import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:qr_reader_app/models/scan_model.dart';
export 'package:qr_reader_app/models/scan_model.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {

    if ( _database != null) return _database;

    _database = await initDB();

    return _database;

  }


  initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentsDirectory.path, 'ScansDB.db' );

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: ( Database db, int version ) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' type TEXT,'
          ' value TEXT'
          ')'
        );
      }
    );

  }

  //CREAR Registros
  newScanRaw( ScanModel newScan ) async {

    final db = await database;

    final res = await db.rawInsert(
      "INSER INTO Scans (id,type,value) "
      "VALUES ( ${ newScan.id }, '${ newScan.type }', ${ newScan.value } )"
    );

    return res;

  }

  newScan( ScanModel newScan ) async {

    final db = await database;

    final res = await db.insert('Scans', newScan.toJson());

    return res;

  }

  //SELECT - Obtener información
  Future<ScanModel> getScanId( int id ) async {

    final db = await database;

    final res = await db.query('Scans', where: 'id = ?', whereArgs: [ id ] );

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;

  }

  Future<List<ScanModel>> getAllScan() async {

    final db = await database;

    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty 
                            ? res.map( (scan) => ScanModel.fromJson(scan)).toList()
                            : [];

    return list;
  }

  Future<List<ScanModel>> getScansForType( String type ) async {

    final db = await database;

    final res = await db.rawQuery("SELECT * FROM Scans WHERE type = '$type'");

    List<ScanModel> list = res.isNotEmpty 
                            ? res.map( (scan) => ScanModel.fromJson(scan)).toList()
                            : [];

    return list;
  }

  //UPDATE - Actualizar Registros
  Future<int>  updateScan( ScanModel scanUpdate ) async  {

    final db = await database;

    final res = await db.update('Scans',  scanUpdate.toJson(), where: 'id = ?', whereArgs: [ scanUpdate.id ]);

    return res;
  }

  //DELETE - Eliminar Registros
  Future<int> deleteScan( ScanModel scanDelete ) async {

    final db = await database;

    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [ scanDelete.id ]);

    return res;

  }

  Future<int> deleteAll() async {

    final db = await database;

    final res = await db.rawDelete("DELETE FROM Scans");

    return res;

  }

}