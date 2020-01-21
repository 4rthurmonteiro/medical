import 'package:flutter/material.dart';
import 'package:medical/screens/equations/cardio/mean_blood_pressure/mean_blood_pressure_card.dart';

class EquationsScreen extends StatefulWidget {
  @override
  _EquationsScreenState createState() => _EquationsScreenState();
}

class _EquationsScreenState extends State<EquationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cardiologia"),
      ),
      body: Column(
        children: <Widget>[
          meanBloodPressureCard(context)
        ],
      ),
    );
  }
}
