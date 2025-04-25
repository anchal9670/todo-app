import 'package:flutter/material.dart';
import 'package:todoapp/src/features/todo/views/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeView(),
    );
  }
}
