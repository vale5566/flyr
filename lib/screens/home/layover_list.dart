import 'package:flutter/material.dart';
import 'package:flyr/models/layover.dart';
import 'package:flyr/screens/home/connect.dart';
import 'package:flyr/screens/home/layover_tile.dart';
import 'package:provider/provider.dart';

class LayoverList extends StatefulWidget {
  @override
  _LayoverListState createState() => _LayoverListState();
}

class _LayoverListState extends State<LayoverList> {
  @override
  Widget build(BuildContext context) {
    final layovers = Provider.of<List<Layover>>(context) ?? [];
    var filteredLayovers;
    if (DataSearch.selectedAirport == null ||
        DataSearch.selectedAirport == "Show all Airports") {
      filteredLayovers = layovers;
    } else {
      filteredLayovers = layovers
          .where((layover) => layover.airport == DataSearch.selectedAirport)
          .toList();
    }

    return ListView.builder(
      itemCount: filteredLayovers.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: LayoverTile(layover: filteredLayovers[index]),
          onTap: () => Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Coming soon"))),
        );
        return LayoverTile(layover: filteredLayovers[index]);
      },
    );
  }
}
