import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flyr/data/airports.dart';
import 'package:intl/intl.dart';

class AddLayoverDialog extends StatefulWidget {
  @override
  _AddLayoverDialogState createState() => _AddLayoverDialogState();
}

class _AddLayoverDialogState extends State<AddLayoverDialog> {
  String airport = "select airport";

  @override
  Widget build(BuildContext context) {
    var airports = airportsCreateArray;
    DateTime now = new DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
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

    return AlertDialog(
      title: Text("Add Layover"),
      elevation: 24.0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DropdownButtonFormField<String>(
              value: airport,
              items: airports.map((String airport) {
                return new DropdownMenuItem<String>(
                  value: airport,
                  child: new Text(airport),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  airport = newValue;
                });
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
                if (pickedEnd == null ||
                    pickedStart == null ||
                    airport == "select airport") {
                  Flushbar(
                    message: "Something is missing..",
                    duration: Duration(seconds: 3),
                  ).show(context);
                } else {
                  var formatter = DateFormat("d MMMM");
                  String formattedPickedStart = formatter.format(pickedStart);
                  String formattedPickedEnd = formatter.format(pickedEnd);
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  String name;
                  int age;
                  if (pickedStart.isBefore(pickedEnd) ||
                      pickedStart == pickedEnd) {
                    Firestore.instance
                        .collection("users")
                        .document(user.uid)
                        .get()
                        .then((docSnap) {
                          name = docSnap["name"];
                          age = docSnap["age"];
                        })
                        .then((result) => {
                              Firestore.instance.collection("layovers").add({
                                "airport": airport,
                                "startDate": formattedPickedStart,
                                "endDate": formattedPickedEnd,
                                "name": name,
                                "age": age,
                              }).then((result) => {
                                    Navigator.of(context).pop(),
                                  })
                            })
                        .catchError((err) => print(err));
                  } else {
                    Flushbar(
                      icon: Icon(Icons.info_outline),
                      margin: EdgeInsets.all(8),
                      borderRadius: 8,
                      message: "End Date is before Start Date",
                      duration: Duration(seconds: 3),
                    ).show(context);
                  }
                }
              }),
        ],
      ),
    );
  }
}
