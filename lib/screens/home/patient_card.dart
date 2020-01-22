import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical/models/patient.dart';
import 'package:medical/screens/home/patient_sheet.dart';
import 'package:medical/screens/result/result_screen.dart';
import 'package:medical/utils/nav.dart';

Widget patientCard(BuildContext context, Patient item){
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white70,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Nome: "),
                      Text(item.name ?? ""),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Data de nascimento: "),
                      Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(item.dayBirth))),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Sexo: "),
                      Text(item.gender == 'M' ? "Masculino" : "Feminino"),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    ),
    onTap: (){
      showModalBottomSheet(

          context: context,
          builder: (context) => PatientSheet(patient: item));
    },
  );
}