import 'package:flutter/material.dart';
import 'package:reminderapp/login.dart';
import 'package:reminderapp/authservice.dart';
import 'package:reminderapp/homepage.dart';
AuthService appAuth = new AuthService();

void main() async {
  // Set default home.
  Widget _defaultHome = new LoginPage();

  // Get result of the login function.
  bool _result = await appAuth.login();
  print(_result);
  if (_result) {
    _defaultHome = new HomePage();
  }


runApp(new MaterialApp(
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new LoginPage()
    },
  ));
}