import 'package:flutter/material.dart';
import 'package:housy_task_2/router.dart';
import 'package:housy_task_2/screens/welcome_screen.dart';

void main() {
  runApp(MyApp(
    router: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({this.router});
  final AppRouter? router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
      onGenerateRoute: router!.generateRoute,
    );
  }
}
