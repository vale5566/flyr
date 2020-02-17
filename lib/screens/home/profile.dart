import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flyr/services/auth.dart';
import 'package:flyr/services/database.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
        value: DatabaseService().users,
    child: Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        child: RaisedButton(
          child: Text("logout"),
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ),
    ));
  }
}