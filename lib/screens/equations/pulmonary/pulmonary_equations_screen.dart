import 'package:flutter/material.dart';
import 'package:medical/screens/equations/cardio/imc/imc_card.dart';
import 'package:medical/screens/equations/cardio/ldl/ldl_card.dart';
import 'package:medical/screens/equations/cardio/mean_blood_pressure/mean_blood_pressure_card.dart';
import 'package:medical/screens/equations/pulmonary/cst/cst_card.dart';
import 'package:medical/screens/equations/pulmonary/rva/rva_card.dart';
import 'package:medical/screens/equations/pulmonary/tidal_volume/tidal_volume_card.dart';

class PulmonaryEquationsScreen extends StatefulWidget {
  final int patientId;

  PulmonaryEquationsScreen({@required this.patientId});

  @override
  _PulmonaryEquationsScreenState createState() => _PulmonaryEquationsScreenState();
}

class _PulmonaryEquationsScreenState extends State<PulmonaryEquationsScreen> {

  int get patientId => widget.patientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pulmonar"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          tidalVolumeCard(context, patientId),
          rvaCard(context, patientId),
          cstCard(context, patientId)
        ],
      ),
    );
  }
}
