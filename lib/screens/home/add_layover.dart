import 'package:flutter/material.dart';
import 'package:flyr/data/airports.dart';

final _formKey = GlobalKey<FormState>();

final airports = airportsArray;

void addLayover(context) {
  DateTime currentDate = DateTime.now();
  String airport = "select Airport";

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime pickedStart = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(2100));
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime pickedEnd = await showDatePicker(
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
                DropdownButton<String>(
                    items: airportsArray.map((String airport) {
                      return new DropdownMenuItem<String>(
                        value: airport,
                        child: new Text(airport),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
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
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      });
}
