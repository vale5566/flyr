import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  final CollectionReference layover = Firestore.instance.collection("layovers");

  Future updateUserData(String name, int age) async {
    return await layover.document(uid).setData({
      "name": name,
      "age": age,
    });
  }
}