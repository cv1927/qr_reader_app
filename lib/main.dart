import 'package:flutter/material.dart';

import 'package:qr_reader_app/pages/home_page.dart';
import 'package:qr_reader_app/pages/map_page.dart';
 
void main() => runApp(QRScannerApp());
 
class QRScannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      initialRoute: 'home',
      routes: {
        'home'  : (BuildContext context) => HomePage(),
        'map'  : (BuildContext context) => MapPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}