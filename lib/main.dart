import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ibec_test/screens/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iBEC test',
      theme: ThemeData.dark(),
      // theme: ThemeData(
      //   primarySwatch: Colors.teal,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: MainScreen(),
    );
  }
}
