import 'package:flutter/material.dart';
import 'UI/get_started.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Cast',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const GetStarted(),
      debugShowCheckedModeBanner: false,
    );
  }
}
