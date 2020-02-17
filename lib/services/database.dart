import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flyr/models/layover.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  final CollectionReference UserCollection = Firestore.instance.collection("users");
  final CollectionReference LayoverCollection = Firestore.instance.collection("layovers");

  Future updateUserData(String name, int age) async {
    return await UserCollection.document(uid).setData({
      "name": name,
      "age": age,
    });
  }

  List<Layover> _layoverListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Layover(
        airport: doc.data['airports'] ?? '',
        name: doc.data['name'] ?? '',
        age: doc.data['age'] ?? 0,
        startDate: doc.data['startDate'] ?? '',
        endDate: doc.data['endDate'] ?? ''
      );
    }).toList();
  }

  Stream<QuerySnapshot> get users {
    return UserCollection.snapshots();
  }

  Stream<List<Layover>> get layovers {
    return LayoverCollection.snapshots().map(_layoverListFromSnapshot);
  }
}
