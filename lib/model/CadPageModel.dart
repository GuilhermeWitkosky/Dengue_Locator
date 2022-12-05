import 'dart:ffi';

class CadPage {
   String? uid;
   String? description;
   int? criticality;
   String? image;
   DateTime? date;
   double? longitude;
   double? latitude;

  CadPage({this.uid, this.description, this.criticality, this.image, this.date, this.longitude, this.latitude});
}