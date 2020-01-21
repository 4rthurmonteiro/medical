import 'package:flutter/cupertino.dart';

Widget bodyBack(){
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 124, 206, 181),
          Color.fromARGB(255, 182, 243, 225),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
      )
    ),
  );
}