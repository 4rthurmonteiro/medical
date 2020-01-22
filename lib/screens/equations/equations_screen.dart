import 'package:flutter/material.dart';
import 'package:medical/screens/equations/cardio/mean_blood_pressure/mean_blood_pressure_card.dart';

class EquationsScreen extends StatefulWidget {
  final int patientId;

  EquationsScreen({@required this.patientId});

  @override
  _EquationsScreenState createState() => _EquationsScreenState();
}

class _EquationsScreenState extends State<EquationsScreen> {

  int get patientId => widget.patientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cardiologia"),
      ),
      body: Column(
        children: <Widget>[
          meanBloodPressureCard(context, patientId)
        ],
      ),
    );
  }
}
