import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  final String description;
  final double latitude;
  final double longitude;
  final int criticality;
  final Timestamp date;
  final String? uid;
  final String image;

  LocationModel(this.description, this.latitude, this.longitude,
      this.criticality, this.date, this.uid, this.image);
}
