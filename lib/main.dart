import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SignInPage.dart';
import 'SignUpPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireBase Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:SignInPage(),
      routes: <String, WidgetBuilder>{
        "/SignInPage": (BuildContext context) => SignInPage(),
        "/SignUnPage": (BuildContext context) => SignUpPage(),
      },
      
    );
  }
}