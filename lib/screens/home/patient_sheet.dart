import 'package:flutter/material.dart';
import 'package:medical/models/patient.dart';
import 'package:medical/screens/home/create_screen.dart';
import 'package:medical/screens/patient/patient_screen.dart';
import 'package:medical/utils/nav.dart';

class PatientSheet extends StatelessWidget {
  final Patient patient;

  const PatientSheet({this.patient});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(builder: (BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FlatButton(
          onPressed: (){
            push(context, PatientScreen(patient: patient));
          },
          child: Text("Entrar"),
        ),
        FlatButton(
          onPressed: (){
            push(context, CreateScreen(patient: patient));
          },
          child: Text("Editar"),
        )
      ],
    ), onClosing: () {},);
  }
}
