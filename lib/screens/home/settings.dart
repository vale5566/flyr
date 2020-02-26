import 'package:flutter/material.dart';
import 'package:flyr/services/auth.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: RaisedButton(
        child: Text("Logout"),
        onPressed: () async {
          await _auth.signOut();
        },
      ),
    );
  }
}
