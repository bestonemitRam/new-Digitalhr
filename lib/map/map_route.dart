// import 'dart:async';
// import 'dart:collection';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapRoute extends StatefulWidget {
//   const MapRoute({Key? key}) : super(key: key);

//   @override
//   _MapRouteState createState() => _MapRouteState();
// }

// class _MapRouteState extends State<MapRoute> {
// // created controller to display Google Maps
//   Completer<GoogleMapController> _controller = Completer();
// //on below line we have set the camera position
//   static final CameraPosition _kGoogle = const CameraPosition(
//     target: LatLng(19.0759837, 72.8776559),
//     zoom: 14,
//   );

//   final Set<Marker> _markers = {};
//   final Set<Polyline> _polyline = {};

// //list of locations to display polylines
//   List<LatLng> latLen =
//   [
//     LatLng(19.0759837, 72.8776559),
//     LatLng(28.679079, 77.069710),
//     LatLng(26.850000, 80.949997),
//     LatLng(24.879999, 74.629997),
//     LatLng(16.166700, 74.833298),
//     LatLng(12.971599, 77.594563),
//   ];

//   @override
//   void initState()
//    {
//     // TODO: implement initState
//     super.initState();
//     // declared for loop for various locations
//     for (int i = 0; i < latLen.length; i++)
//     {
//       _markers.add(
//           // added markers
//           Marker(
//         markerId: MarkerId(i.toString()),
//         position: latLen[i],
//         infoWindow: InfoWindow(
//           title: 'HOTEL',
//           snippet: '5 Star Hotel',
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//       ));
//       setState(()
//       {

//       });
//       _polyline.add(Polyline(
//         polylineId: PolylineId('1'),
//         points: latLen,
//         color: Colors.green,
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context)
//    {
//     return Scaffold(
//       body: Container(
//         child: SafeArea(
//           child: GoogleMap(
//             //given camera position
//             initialCameraPosition: _kGoogle,
//             //on below line we have given map type
//             mapType: MapType.normal,

//             markers: _markers,
//             // on below line we have enabled location
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//             // on below line we have enabled compass location
//             compassEnabled: true,
//             // on below line we have added polylines
//             polylines: _polyline,
//             // displayed google map
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapRoute extends StatefulWidget {
//   const MapRoute({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<MapRoute> {
// // on below line we are initializing our controller for google maps.
//   Completer<GoogleMapController> _controller = Completer();

// // on below line we are specifying our camera position
//   static final CameraPosition _kGoogle = const CameraPosition(
//     target: LatLng(37.42796133580664, -122.885749655962),
//     zoom: 14.4746,
//   );

// // on below line we have created list of markers
//   List<Marker> _marker = [];
//   final List<Marker> _list = const [
//     // List of Markers Added on Google Map
//     Marker(
//         markerId: MarkerId('1'),
//         position: LatLng(20.42796133580664, 80.885749655962),
//         infoWindow: InfoWindow(
//           title: 'My Position',
//         )),

//     Marker(
//         markerId: MarkerId('2'),
//         position: LatLng(25.42796133580664, 80.885749655962),
//         infoWindow: InfoWindow(
//           title: 'Location 1',
//         )),

//     Marker(
//         markerId: MarkerId('3'),
//         position: LatLng(20.42796133580664, 73.885749655962),
//         infoWindow: InfoWindow(
//           title: 'Location 2',
//         )),
//   ];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _marker.addAll(_list);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color(0xFF0F9D58),
//           title: Text("GFG"),
//         ),
//         body: Container(
//           // on below line creating google maps.
//           child: GoogleMap(
//             // on below line setting camera position
//             initialCameraPosition: _kGoogle,
//             // on below line specifying map type.
//             mapType: MapType.normal,
//             // on below line setting user location enabled.
//             myLocationEnabled: true,
//             // on below line setting compass enabled.
//             compassEnabled: true,
//             // on below line specifying controller on map complete.
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//           ),
//         ));
//   }
// }

class MapRoute extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapRoute> {
  late GoogleMapController mapController;

  final List<Marker> markers = [
    Marker(
      markerId: MarkerId('marker1'),
      position: LatLng(37.7749, -122.4194),
      infoWindow: InfoWindow(title: 'Marker 1'),
    ),
    Marker(
      markerId: MarkerId('marker2'),
      position: LatLng(37.7892, -122.4020),
      infoWindow: InfoWindow(title: 'Marker 2'),
    ),
    Marker(
      markerId: MarkerId('marker3'),
      position: LatLng(37.7749, -122.4869),
      infoWindow: InfoWindow(title: 'Marker 3'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map with Multiple Markers'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 10,
        ),
        markers: Set.from(markers),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
