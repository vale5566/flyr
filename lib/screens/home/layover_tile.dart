import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyr/models/layover.dart';

class LayoverTile extends StatelessWidget {
  final Layover layover;

  LayoverTile({this.layover});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        child: ListTile(
          leading: Icon(
            Icons.flight_takeoff,
            size: 40.0,
          ),
          title: Text(layover.airport),
          subtitle: Text("From: " +
              layover.startDate +
              " To: " +
              layover.endDate +
              "\n" +
              "Name: " +
              layover.name +
              " Age: " +
              layover.age.toString()),
          isThreeLine: true,
        ),
      ),
    );
  }
}
