import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyr/models/user.dart';
import 'package:flyr/services/database.dart';
import 'package:flyr/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:flyr/shared/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _currentName;
  int _currentAge;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User userData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('Profile'),
              ),
              body: new Container(
                padding: const EdgeInsets.all(40.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          new InputDecoration(labelText: "Enter your age"),
                      initialValue: userData.age.toString(),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      onChanged: (val) =>
                          setState(() => _currentAge = int.parse(val)),
                    ),
                    SizedBox(height: 50.0),
                    TextFormField(
                      initialValue: userData.name,
                      decoration:
                          new InputDecoration(labelText: "Enter your name"),
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 40.0),
                    RaisedButton(
                        child: Text("Save"),
                        onPressed: () async {
                          if (_currentName == null && _currentAge == null) {
                          } else {
                            if (_currentAge == null) {
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(_currentName, userData.age);
                            } else {
                              if (_currentName == null) {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(userData.name, _currentAge);
                              } else {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(_currentName, _currentAge)
                                    .whenComplete(() {
                                });
                              }
                            }
                          }
                        }),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
