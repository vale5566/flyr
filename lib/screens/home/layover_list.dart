import 'package:flutter/material.dart';
import 'package:flyr/models/layover.dart';
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

    return ListView.builder(
      itemCount: layovers.length,
      itemBuilder: (context, index) {
        return LayoverTile(layover: layovers[index]);
      },
    );
  }
}
