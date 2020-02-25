import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyr/data/airports.dart';
import 'package:intl/intl.dart';

final _formKey = GlobalKey<FormState>();

final airports = airportsArray;

void addLayover(context) {
  DateTime currentDate = DateTime.now();
  String airport = "select airport";
  DateTime pickedStart;
  DateTime pickedEnd;

  Future<Null> _selectStartDate(BuildContext context) async {
    pickedStart = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(2100));
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    pickedEnd = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(2100));
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButtonFormField<String>(
                    value: airport,
                    items: airportsArray.map((String airport) {
                      return new DropdownMenuItem<String>(
                        value: airport,
                        child: new Text(airport),
                      );
                    }).toList(),
                    onChanged:
                        (String newValue) {
                      airport = newValue;
                    }),
                RaisedButton(
                  child: Text("Pick Start Date"),
                  onPressed: () => _selectStartDate(context),
                ),
                RaisedButton(
                  child: Text("Pick End Date"),
                  onPressed: () => _selectEndDate(context),
                ),
                RaisedButton.icon(
                  label: Text("Submit"),
                  icon: Icon(Icons.send),
                  color: Colors.amber,
                  onPressed: () async {
                    var formatter = DateFormat("d MMMM");
                    String formattedPickedStart = formatter.format(pickedStart);
                    String formattedPickedEnd = formatter.format(pickedEnd);
                    FirebaseUser user = await FirebaseAuth.instance
                        .currentUser();
                    String name;
                    int age;
                    Firestore.instance.collection("users")
                        .document(user.uid)
                        .get()
                        .then((docSnap) {
                      name = docSnap["name"];
                      age = docSnap["age"];
                    }).then((result) => {
                    Firestore.instance
                        .collection("layovers")
                        .add({
                    "airport": airport,
                    "startDate": formattedPickedStart,
                    "endDate": formattedPickedEnd,
                    "name": name,
                    "age": age,
                    })
                        .then((result) => {
                    Navigator.pop(context),
                    })
                        .catchError((err) => print(err))
                    });
                  },
                ),
              ],
            ),
          ),
        );
      });
}
