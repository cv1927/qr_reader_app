import 'package:flutter/material.dart';

import 'package:qrcode_reader/qrcode_reader.dart';

import 'package:qr_reader_app/pages/address_page.dart';
import 'package:qr_reader_app/pages/map_page.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.delete_forever ),
            onPressed: () {},
          )
        ],
      ),
      body: _callPage(pageIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQR,
        child: Icon( Icons.filter_center_focus ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR() async {
    
    String futureString = '';

    // try {
    //   futureString = await new QRCodeReader().scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }

    // print('futureString: $futureString');

    // if ( futureString != null) {
    //   print('HAY INFORMACION');
    // }

  }

  Widget _callPage( int pageNow ) {
    switch ( pageNow ) {
      case 0: return MapPage();
      case 1: return AddressPage();

      default:
        return MapPage();
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