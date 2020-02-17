import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class LayoverList extends StatefulWidget {
  @override
  _LayoverListState createState() => _LayoverListState();
}

class _LayoverListState extends State<LayoverList> {
  @override
  Widget build(BuildContext context) {

    final layovers = Provider.of<QuerySnapshot>(context);
    for(var doc in layovers.documents) {
      print(doc.data);
    }

    return Container(

    );
  }
}
