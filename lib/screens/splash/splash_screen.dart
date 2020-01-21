import 'package:flutter/material.dart';
import 'package:medical/screens/home/home_screen.dart';
import 'package:medical/utils/database_helper.dart';
import 'package:medical/utils/nav.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();


    Future futureA = Future.delayed(Duration(seconds: 3));

    Future futureB = DatabaseHelper.getInstance().db;


    Future.wait([futureA, futureB]).then((List values) async {


      pushReplacement(context, HomeScreen());

    });
  }
}
