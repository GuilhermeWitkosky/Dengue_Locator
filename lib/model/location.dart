import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  final String description;
  final double latitude;
  final double longitude;
  final int criticality;
  final Timestamp date;

  LocationModel(this.description, this.latitude, this.longitude,
      this.criticality, this.date);
}