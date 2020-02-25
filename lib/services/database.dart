import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flyr/models/layover.dart';
import 'package:flyr/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection("users");
  final CollectionReference layoverCollection =
      Firestore.instance.collection("layovers");

  Future updateUserData(String name, int age) async {
    return await userCollection.document(uid).setData({
      "name": name,
      "age": age,
    });
  }

  List<Layover> _layoverListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Layover(
        airport: doc.data['airport'] ?? '',
        name: doc.data['name'] ?? '',
        age: doc.data['age'] ?? 0,
        startDate: doc.data['startDate'] ?? '',
        endDate: doc.data['endDate'] ?? '',
      );
    }).toList();
  }

  Stream<User> get users {
    return userCollection.document(uid).snapshots().map((doc) {
      return User(
        uid: uid,
        name: doc.data["name"],
        age: doc.data["age"],
      );
    });
  }

  Stream<List<Layover>> get layovers {
    return layoverCollection.snapshots().map(_layoverListFromSnapshot);
  }
}
