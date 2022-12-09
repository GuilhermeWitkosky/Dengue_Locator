import 'package:degue_locator/dbo/firebase_connection.dart';
import 'package:degue_locator/editInformation/edit_page.dart';
import 'package:degue_locator/login/login_page.dart';
import 'package:degue_locator/model/location.dart';
import 'package:degue_locator/registration/cadastro_page.dart';
import 'package:degue_locator/widget/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(-26.4669318, -49.1174139),
    zoom: 15,
  );

  late GoogleMapController _googleMapController;
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  Set<Marker> _markers = {};
  BitmapDescriptor markerIconHigh = BitmapDescriptor.defaultMarker;
  BitmapDescriptor markerIconMedium = BitmapDescriptor.defaultMarker;
  BitmapDescriptor markerIconLow = BitmapDescriptor.defaultMarker;
  List<String> priority = ['Baixa', 'Média', 'Alta'];

  @override
  void initState() {
    // TODO: implement initState
    addCustomIcon();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _googleMapController = controller;
      getMarkers();
    });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut().then(
          (user) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WidgetTree(),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 63, 84, 1),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Dengue Locator',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: GoogleFonts.kaushanScript().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                logout();
              },
            ),
          ],
        ),
        body: GoogleMap(
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: _onMapCreated,
          markers: _markers,
        ),
        floatingActionButton: Container(
          child: Align(
              alignment: Alignment(0.1, 0.95),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 63, 84, 1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CadastroPage())),
                child: const Text(
                  'Informar foco',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )),
        ));
  }

  getMarkers() async {
    _markers.clear();
    Set<Marker> _markerTemp = {};
    FirebaseCrud.readLocalizations().listen((event) {
      event.docs.forEach((element) {
        LocationModel location = LocationModel(
            element.get('description'),
            element.get('latitude').runtimeType == 'int'
                ? element.get('latitude').toDouble()
                : element.get('latitude'),
            element.get('longitude').runtimeType == 'int'
                ? element.get('longitude').toDouble()
                : element.get('longitude'),
            element.get('criticality'),
            element.get('date'),
            element.id,
            element.get('image'),
            element.get('status'),
            element.get('email'));
        _markerTemp.add(Marker(
          markerId: MarkerId(location.description),
          position: LatLng(location.latitude, location.longitude),
          infoWindow: InfoWindow(
              title: DateFormat('dd/MM/yyyy').format(location.date.toDate()),
              snippet:
                  location.description + ' - ' + priority[location.criticality],
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPage(
                              locationModel: location!,
                            )));
              }),
          icon: selectCustomIcon(priority[element.get('criticality')]),
        ));
      });
      setState(() {
        _markers = _markerTemp;
      });
    });
  }

  selectCustomIcon(String priority) {
    switch (priority) {
      case 'Baixa':
        return markerIconLow;
      case 'Média':
        return markerIconMedium;
      case 'Alta':
        return markerIconHigh;
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  addCustomIcon() async {
    String iconPathHigh = 'images/icon_high.png';
    String iconPathMedium = 'images/icon_medium.png';
    String iconPathLow = 'images/icon_low.png';
    Uint8List markerIconBytesHigh = await getBytesFromAsset(iconPathHigh, 100);
    Uint8List markerIconBytesMedium =
        await getBytesFromAsset(iconPathMedium, 100);
    Uint8List markerIconBytesLow = await getBytesFromAsset(iconPathLow, 100);
    setState(() {
      markerIconHigh = BitmapDescriptor.fromBytes(markerIconBytesHigh);
      markerIconMedium = BitmapDescriptor.fromBytes(markerIconBytesMedium);
      markerIconLow = BitmapDescriptor.fromBytes(markerIconBytesLow);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
