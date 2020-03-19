import 'package:flutter/material.dart';
import 'package:flyr/data/airports.dart';
import 'package:flyr/models/layover.dart';
import 'package:flyr/screens/home/layover_list.dart';
import 'package:flyr/services/database.dart';
import 'package:provider/provider.dart';

class Connect extends StatefulWidget {
  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Layover>>.value(
      value: DatabaseService().layovers,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Connect'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
          ],
        ),
        body: LayoverList(),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  var airports = airportsSearchArray;
  static String selectedAirport;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? airports
        : airports
            .where((p) => p.contains(RegExp(query, caseSensitive: false)))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          selectedAirport = suggestionList[index];
          close(context, null);
        },
        leading: Icon(Icons.local_airport),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}
