import 'package:flutter/material.dart';

//THIRDS
import 'package:flutter_map/flutter_map.dart';

//MODEL
import 'package:qr_reader_app/models/scan_model.dart';

class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final controllerMap = new MapController();
  String typeMap = 'streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.my_location ),
            onPressed: () {
              controllerMap.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createButtonFloat( context ),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {

    return FlutterMap(
      mapController: controllerMap,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        _createMap(),
        _createMarkers( scan ),
      ],
    );

  }

  _createMap() {

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiZnJlZW1hcHMxOTI3IiwiYSI6ImNrMWZpMnduNDBybTIzZ28zZW1zbHZ3MHgifQ.ZvbNQ6hYyY7zodCS-05_Og',
        'id': 'mapbox.$typeMap'
        // streets,dark,light,outdoors,satellite
      }
    );

  }

  _createMarkers( ScanModel scan ) {

    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: ( context ) => Container(
            child: Icon( 
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          )
        )
      ]
    );

  }

  Widget _createButtonFloat(BuildContext context) {
    
    return FloatingActionButton(
      child: Icon( Icons.map ),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
          
          // streets,dark,light,outdoors,satellite
          if ( typeMap == 'streets' ) {
            typeMap = 'dark';
          } else if ( typeMap == 'dark' ) {
            typeMap = 'light';
          } else if ( typeMap == 'light' ) {
            typeMap = 'outdoors';
          } else if ( typeMap == 'outdoors' ) {
            typeMap = 'satellite';
          } else if ( typeMap == 'satellite' ) {
            typeMap = 'streets';
          }

        setState(() {});

      },
    );

  }
}