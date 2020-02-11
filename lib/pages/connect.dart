import 'package:flutter/material.dart';

class Connect extends StatefulWidget {
  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {

  final airports = [
    "Berlin (BER)",
    "München (MUC)",
    "Frankfurt am Main (FRA)",
    "Hamburg International (HAM)",
    "Düsseldorf (DUS)",
    "Stuttgart (STR)",
    "Köln (CGN)",
    "Hannover (HAJ)",
    "Nürnberg (NUE)",
    "Dresden (DRS)",
    "Leipzig (LEJ)",
    "Bremen (BRE)",
    "Münster Osnabrück (FMO)",
    "Friedrichshafen (FDH)",
    "Dortmund (DTM)",
    "Palma de Mallorca (PMI)",
    "Istanbul (IST)",
    "London-Heathrow (LHR)",
    "Thessaloniki (SKG)",
    "New York (JFK)",
    "Wien (VIE)",
    "Zürich (ZRH)",
    "Barcelona (BCN)",
    "Bangkok (BKK)",
    "Amsterdam Schiphol (AMS)",
    "Lissabon (LIS)",
    "Madrid (MAD)",
    "Shanghai (PVG)",
    "Taipeh (TPE)"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = "";
    })];
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
  Widget buildResults(BuildContext context) {
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? airports : airports.where((p) => p.contains(RegExp(query, caseSensitive: false))).toList();

    return ListView.builder(itemBuilder: (context,index)=>ListTile(
      onTap: () {
        showResults(context);
      },
      leading: Icon(Icons.local_airport),
      title: Text(suggestionList[index]),
    ),
    itemCount: suggestionList.length,
    );
  }
}
