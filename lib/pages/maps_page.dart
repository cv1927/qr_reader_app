import 'package:flutter/material.dart';

//BLOC
import 'package:qr_reader_app/bloc/scan_bloc.dart';

//MODEL
import 'package:qr_reader_app/models/scan_model.dart';

//UTILS
import 'package:qr_reader_app/utils/utils.dart' as utils;

class MapsPage extends StatelessWidget {

  final scanBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scanBloc.getScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scanBloc.scanStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        
        if ( !snapshot.hasData ) {
          return Center( child: CircularProgressIndicator());
        }

        final scan = snapshot.data;

        if ( scan.length == 0 ) {
          return Center(
            child: Text('No hay información'),
          );
        }

        return ListView.builder(
          itemCount: scan.length,
          itemBuilder: ( context, i ) => Dismissible(
            key: UniqueKey(),
            background: Container( color: Colors.red,),
            onDismissed: ( direcction ) => scanBloc.deleteScan( scan[i] ),
            child: ListTile(
              leading: Icon( Icons.map, color: Theme.of(context).primaryColor, ),
              title: Text( scan[i].value ),
              subtitle: Text('ID: ${ scan[i].id }'),
              trailing: Icon ( Icons.keyboard_arrow_right, color: Colors.grey, ),
              onTap: () => utils.openScan(context,scan[i]),
            ),
          )
        );

      },
    );
  }
}

// FutureBuilder<List<ScanModel>>(
//       future: DBProvider.db.getAllScan(),
//       builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        
//         if ( !snapshot.hasData ) {
//           return Center( child: CircularProgressIndicator());
//         }

//         final scan = snapshot.data;

//         if ( scan.length == 0 ) {
//           return Center(
//             child: Text('No hay información'),
//           );
//         }

//         return ListView.builder(
//           itemCount: scan.length,
//           itemBuilder: ( context, i ) => Dismissible(
//             key: UniqueKey(),
//             background: Container( color: Colors.red,),
//             onDismissed: ( direcction ) => DBProvider.db.deleteScan( scan[i] ),
//             child: ListTile(
//               leading: Icon( Icons.cloud_queue, color: Theme.of(context).primaryColor, ),
//               title: Text( scan[i].value ),
//               subtitle: Text('ID: ${ scan[i].id }'),
//               trailing: Icon ( Icons.keyboard_arrow_right, color: Colors.grey, ),
//             ),
//           )
//         );

//       },
//     );