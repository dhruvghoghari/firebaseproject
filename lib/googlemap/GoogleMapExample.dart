import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapExample extends StatefulWidget {

  @override
  State<GoogleMapExample> createState() => _GoogleMapExampleState();
}
class _GoogleMapExampleState extends State<GoogleMapExample> {

  GoogleMapController? _controller;
  Set<Marker> _markers = {}; // Set to store markers
  Set<Marker> _temp = {};
  getdata() async
  {
    print("GetData called");
    await FirebaseFirestore.instance.collection("location").get().then((documents){

        documents.docs.forEach((document) {
         _temp.add(
           Marker(
             markerId: MarkerId(document.id.toString()),
             position: LatLng(double.parse(document["latitude"].toString()),double.parse(document["longtitude"].toString())),
             icon: BitmapDescriptor.defaultMarker,
             infoWindow: InfoWindow(
               title: document["name"].toString(),
               snippet: document["name"].toString(),
             ),
           ),
         );
      });
    }).then((value){
      setState(() {
        _markers = _temp;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    // _markers.add(
    //     Marker(
    //       markerId: MarkerId("marker_id"), // Unique marker id
    //       position: LatLng(21.1702, 72.8311), // Specific location coordinates
    //       icon: BitmapDescriptor.defaultMarker, // You can customize the icon here
    //       infoWindow: InfoWindow(
    //         title: "Surat",
    //         snippet: "City Of India",
    //       ),
    //     ),
    // );
    // _markers.add(
    //   Marker(
    //     markerId: MarkerId("marker_id"),
    //     position: LatLng(21.1959, 72.7933),
    //     icon: BitmapDescriptor.defaultMarker,
    //     infoWindow: InfoWindow(
    //       title: "Adajn",
    //       snippet: "City Of India",
    //     ),
    //   ),
    // );
    // _markers.add(
    //   Marker(
    //     markerId: MarkerId("marker_id"),
    //     position: LatLng(21.2021, 72.8673),
    //     icon: BitmapDescriptor.defaultMarker,
    //     infoWindow: InfoWindow(
    //       title: "Varacaha",
    //       snippet: "City Of India",
    //     ),
    //   ),
    // );
    // _markers.add(
    //   Marker(
    //     markerId: MarkerId("marker_id"),
    //     position: LatLng(21.1431, 72.8431),
    //     icon: BitmapDescriptor.defaultMarker,
    //     infoWindow: InfoWindow(
    //       title: "Udhana",
    //       snippet: "City Of India",
    //     ),
    //   ),
    // );
    // _markers.add(
    //   Marker(
    //     markerId: MarkerId("marker_id"),
    //     position: LatLng(21.2469, 72.8515),
    //     icon: BitmapDescriptor.defaultMarker,
    //     infoWindow: InfoWindow(
    //       title: "Amroli",
    //       snippet: "City Of India",
    //     ),
    //   ),
    //
    // );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(21.1702, 72.8311),
          zoom: 14.4746
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        myLocationButtonEnabled: true, // Enable the current location button
        myLocationEnabled: true, // Enable current location tracking
        markers: _markers, // Set of markers to display
      ),
    );
  }
}
