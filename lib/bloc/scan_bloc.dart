

import 'dart:async';

import 'package:qr_reader_app/bloc/validator.dart';
import 'package:qr_reader_app/providers/db_provider.dart';

class ScansBloc with Validator {

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    //Obtener Scans de la base de datos
    getScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scanStream => _scansController.stream.transform(valideGeo);
  Stream<List<ScanModel>> get scanStreamHttp => _scansController.stream.transform(valideHttp);

  dispose() {
    _scansController?.close();
  }

  addScan( ScanModel scan ) async {

    await DBProvider.db.newScan(scan);
    getScans();

  }

  getScans() async  {

    _scansController.sink.add( await DBProvider.db.getAllScan() );

  }

  deleteScan( ScanModel scan ) {
    
    DBProvider.db.deleteScan( scan );
    getScans();

  }

  deleteScansAll() async {

    await DBProvider.db.deleteAll();
    getScans();

  }
}