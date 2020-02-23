import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyr/models/user.dart';
import 'package:flyr/services/auth.dart';
import 'package:flyr/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flyr/shared/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  String _currentName;
  int _currentAge;
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamProvider<QuerySnapshot>.value(
        value: DatabaseService().users,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: new Container(
            padding: const EdgeInsets.all(40.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: new InputDecoration(labelText: "Enter your age"),
                  initialValue: user.age.toString(),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  onChanged: (val) => setState(() => _currentAge = val as int),
                ),
                SizedBox(height: 50.0),
                TextFormField(
                  initialValue: user.name,
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 40.0),
                RaisedButton(
                  child: Text("Save"),
                    onPressed: () async {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentName, _currentAge
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
