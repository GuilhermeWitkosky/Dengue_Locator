import 'dart:convert';

import 'package:degue_locator/dbo/firebase_connection.dart';
import 'package:degue_locator/registration/cadastro_page.dart';
import 'package:degue_locator/map/mapScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

// description: descriptionController.text,
//           criticality: criticality,
//           image: image,
//           date: date,

class MapScreen2 extends StatefulWidget {
  MapScreen2(
      {required this.description,
      required this.criticality,
      required this.image,
      required this.date});
  final String description;
  final int criticality;
  final String image;
  final DateTime date;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen2> {
  // static const _initialCameraPosition = CameraPosition(
  //   target: LatLng(-26.4669318, -49.1174139),
  //   zoom: 11.5,
  // );

  late GoogleMapController _googleMapController;

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(-26.4669318, -49.1174139);
  String location = "Location Name";

  static const platformChannelGeolocator = const MethodChannel('geolocator');

  double latitudeAtual = 0;
  double longitudeAtual = 0;

  String localeIdentifier = "";

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  Future buscaLocal(String url) async {
    final response = await http.get(Uri.parse(url));
    final Xml2Json xml = Xml2Json();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      xml.parse(response.body);
      var body = xml.toParker();
      var bodyJson = jsonDecode(body);
      print(bodyJson["GeocodeResponse"]["result"][0]["formatted_address"]);

      setState(() {
        //get place name from lat and lang
        location =
            bodyJson["GeocodeResponse"]["result"][0]["formatted_address"];
      });

      return body;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load street');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                //innital position in map
                target: startLocation, //initial position
                zoom: 17.0, //initial zoom level
              ),
              zoomGesturesEnabled: true, //enable Zoom in, out on map

              mapType: MapType.normal, //map type
              onMapCreated: (controller) {
                //method called when map is created
                setState(() {
                  _googleMapController = controller;
                });
              },
              onCameraMove: (CameraPosition cameraPositiona) {
                cameraPosition = cameraPositiona; //when map is dragging
                latitudeAtual = cameraPositiona.target.latitude;
                longitudeAtual = cameraPositiona.target.longitude;
              },
              onCameraIdle: () async {
                String url =
                    "https://maps.googleapis.com/maps/api/geocode/xml?latlng=" +
                        latitudeAtual.toString() +
                        "," +
                        longitudeAtual.toString() +
                        "&key=AIzaSyCm2dEvrOa5r_Nndplc_aXdQ3ctgnBAH3A";

                buscaLocal(url);
              },
            ),
            Center(
              //picker image on google map
              child: Icon(
                Icons.my_location,
                size: 30,
                color: const Color.fromRGBO(255, 63, 84, 1),
              ),
            ),
            Positioned(
                //widget to display location name
                bottom: 100,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    child: Container(
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListTile(
                          leading: Icon(
                            Icons.my_location,
                            size: 30,
                            color: const Color.fromRGBO(255, 63, 84, 1),
                          ),
                          title: Text(
                            location,
                            style: TextStyle(fontSize: 12),
                          ),
                          dense: true,
                        )),
                  ),
                ))
          ],
        ),
        floatingActionButton: Container(
          child: Container(
              child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(12)),
              Align(
                  alignment: const Alignment(-0.8, 0),
                  child: FloatingActionButton(
                    backgroundColor: const Color.fromRGBO(255, 63, 84, 1),
                    foregroundColor: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  )),
              const Padding(padding: EdgeInsets.all(300 - 43)),
              Align(
                  alignment: const Alignment(0, 1),
                  child: Card(
                      shadowColor: Colors.black26,
                      child: Container(
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(255, 63, 84, 1),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.fromLTRB(80, 15, 80, 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                              child: const Text('Cadastrar'),
                              onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapScreen())),
                                addNewDengueLocalization()
                              },
                            )
                          ],
                        ),
                      )))
            ],
          )),
        ));
  }

  addNewDengueLocalization() async {
    try {
      var response = await FirebaseCrud.addNewLocalization(
          description: widget.description,
          criticality: widget.criticality,
          image: widget.image,
          date: widget.date,
          longitude: longitudeAtual,
          latitude: latitudeAtual,
          email: FirebaseAuth.instance.currentUser?.email);

      if (response.cod != 200) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(response.msg.toString()),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(response.msg.toString()),
              );
            });
      }
    } catch (e) {
      print("Erro: " + e.toString());
    }
  }
}
