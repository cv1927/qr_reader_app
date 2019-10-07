//PACKAGE FLUTTER
import 'dart:io';

import 'package:flutter/material.dart';

//UTILS
import 'package:qr_reader_app/utils/utils.dart' as utils;

//PACKAGE THIRDS
import 'package:qrcode_reader/qrcode_reader.dart';

//BLOC
import 'package:qr_reader_app/bloc/scan_bloc.dart';

//MODEL
import 'package:qr_reader_app/models/scan_model.dart';

//PAGINAS
import 'package:qr_reader_app/pages/address_page.dart';
import 'package:qr_reader_app/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.delete_forever ),
            onPressed: scansBloc.deleteScansAll,
          )
        ],
      ),
      body: _callPage(pageIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scanQR(context),
        child: Icon( Icons.filter_center_focus ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context) async {
    
    String futureString;

    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }

    if ( futureString != null) {
      final scan = new ScanModel(value: futureString);
      scansBloc.addScan(scan);

      if ( Platform.isAndroid || Platform.isIOS ) {
        Future.delayed( Duration( milliseconds: 750 ), () {
          utils.openScan(context,scan);
        });
      } else {
        utils.openScan(context,scan);
      }

    }

  }

  Widget _callPage( int pageNow ) {
    switch ( pageNow ) {
      case 0: return MapsPage();
      case 1: return AddressPage();

      default:
        return MapsPage();
    }
  }

  Widget _createBottomNavigationBar() {

    return BottomNavigationBar(
      currentIndex: pageIndex,
      onTap: (index) {
        setState(() {
         pageIndex  = index; 
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon( Icons.map ),
          title: Text('Mapa')
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.brightness_5 ),
          title: Text('Direcciones')
        ),
      ],
    );

  }
}