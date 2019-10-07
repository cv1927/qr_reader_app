import 'dart:async';

import 'package:qr_reader_app/providers/db_provider.dart';

class Validator {

  final valideGeo = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: ( scans, sink ) {
      
      final geoScans = scans.where( (s) => s.type == 'geo').toList();
      sink.add(geoScans);

    }
  );


  final valideHttp = StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: ( scans, sink ) {
      
      final httpScans = scans.where( (s) => s.type == 'http').toList();
      sink.add(httpScans);

    }
  );
}