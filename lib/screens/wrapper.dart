import 'package:flutter/material.dart';
import 'package:flyr/models/user.dart';
import 'package:flyr/pages/home.dart';
import 'package:flyr/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
