import 'package:flutter/material.dart';
import 'package:medical/models/patient.dart';
import 'package:medical/screens/categories/categories_screen.dart';
import 'package:medical/utils/nav.dart';

class PatientScreen extends StatefulWidget {
  final Patient patient;

  PatientScreen({this.patient});

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paciente"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => push(context, CategoriesScreen()),
        child: Icon(Icons.assignment),


      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ExpansionTile(
//                leading: maskSituationIcon(item.situation),
                  initiallyExpanded: true,
                  title: Text(
                    "TESTE",
                    style: TextStyle(
//                      color: maskSituationColor(item.situation),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 0, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text("Testando"),
                                subtitle: Text("te"),
                              ),
                              ListTile(
                                title: Text("chamaaaaaa"),
                                subtitle: Text("iapois"),
                              ),
                              ListTile(
                                title: Text("dasdadasdasdasda"),
                                subtitle: Text(
                                    "aaaaaaaaaaaa"),
                              ),
                              ListTile(
                                title: Text("dasdasdasdasdasdasdasdsa"),
                                subtitle: Text("dsadasdasd"),
                              ),


                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ExpansionTile(
//                leading: maskSituationIcon(item.situation),
                  initiallyExpanded: true,
                  title: Text(
                    "TESTE",
                    style: TextStyle(
//                      color: maskSituationColor(item.situation),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 0, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text("Testando"),
                                subtitle: Text("te"),
                              ),
                              ListTile(
                                title: Text("chamaaaaaa"),
                                subtitle: Text("iapois"),
                              ),
                              ListTile(
                                title: Text("dasdadasdasdasda"),
                                subtitle: Text(
                                    "aaaaaaaaaaaa"),
                              ),
                              ListTile(
                                title: Text("dasdasdasdasdasdasdasdsa"),
                                subtitle: Text("dsadasdasd"),
                              ),


                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ]),
      )
    );
  }
}
