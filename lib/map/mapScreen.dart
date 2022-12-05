import 'package:degue_locator/dbo/firebase_connection.dart';
import 'package:degue_locator/editInformation/edit_page.dart';
import 'package:degue_locator/model/location.dart';
import 'package:degue_locator/registration/cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

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

  final Set<Marker> _markers = {};
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  List<String> priority = ['Baixa', 'Média', 'Alta'];

  @override
  void initState() {
    // TODO: implement initState
    //markersList = FirebaseCrud.readLocalizations();
    addCustomIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: getMarkers(),
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

  getMarkers() {
    addCustomIcon();
    try {
      FirebaseCrud.readLocalizations().listen((event) {
        print(event.docs[0].data());
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
              element.id
          );
          _markers.add(Marker(
            markerId: MarkerId(location.description),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(
                title: DateFormat('dd/MM/yyyy').format(location.date.toDate()),
                snippet: location.description +
                    ' - ' +
                    priority[location.criticality],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditPage(
                                locationModel: location!,
                              )));
                }),
            icon: markerIcon,
          ));
        });
      });
      return _markers;
    } catch (e) {
      return _markers;
    }
  }

  addCustomIcon() {
    String iconPath = 'images/icon_high.png';
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(50, 50)), iconPath)
        .then((icon) {
      setState(() {
        if (icon != null) {
          markerIcon = icon;
        }
      });
    });
  }
}
