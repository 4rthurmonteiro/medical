import 'package:flutter/material.dart';
import 'package:medical/event_bus/event_bus.dart';
import 'package:medical/screens/home/home_screen.dart';
import 'package:medical/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Medical',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal
        ),
        home: SplashScreen(),
      ),
      create: (BuildContext context) => EventBus(),
      dispose: (context, bus) => bus.dispose(),
    );
  }
}
