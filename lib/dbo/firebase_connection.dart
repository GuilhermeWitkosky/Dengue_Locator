
import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Localization');

class Response{
  int? cod;
  String? msg;
  Response({this.cod, this.msg});
}

class FirebaseCrud{

  static Future<Response> addNewLocalization({
    required String description,
    required int criticality,
    required String image,
    required DateTime date,
    required double longitude,
    required double latitude,
  }) async{
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "description": description,
      "criticality": criticality,
      "image": image,
      "date": date,
      "longitude": longitude,
      "latitude": latitude
    };

    var result = await documentReferencer.set(data).whenComplete((){
      response.cod = 200;
      response.msg = "Localização adicionada ao banco de dados";
    }).catchError((e){
      response.cod = 500;
      response.msg = e;
    });
    return response;
  }

  static Future<Response> updateLocalization({
    required String uid,
    required String description,
    required int criticality,
    required String image,
    required DateTime date,
    required double longitude,
    required double latitude,
  }) async{
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(uid);

    Map<String, dynamic> data = <String, dynamic>{
      "description": description,
      "criticality": criticality,
      "image": image,
      "date": date,
      "longitude": longitude,
      "latitude": latitude
    };

    await documentReferencer.update(data).whenComplete((){
      response.cod = 200;
      response.msg = "Update realizado";
    }).catchError((e){
      response.cod = 500;
      response.msg = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readLocalizations(){
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> deleteLocalization({
    required String uid,
  }) async{
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(uid);

    await documentReferencer.delete().whenComplete((){
      response.cod = 200;
      response.msg = "Deletado";
    }).catchError((e){
      response.cod = 500;
      response.msg = e;
    });

    return response;
  }
}