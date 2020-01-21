import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical/blocs/patient/patient_bloc.dart';
import 'package:medical/event_bus/event_bus.dart';
import 'package:medical/models/event.dart';
import 'package:medical/models/patient.dart';
import 'package:medical/screens/home/create_screen.dart';
import 'package:medical/screens/home/drawer_list.dart';
import 'package:medical/screens/home/patient_card.dart';
import 'package:medical/screens/result/result_screen.dart';
import 'package:medical/utils/colors.dart';
import 'package:medical/utils/nav.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  StreamSubscription<Event> subscription;

  PatientBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(),
      appBar: AppBar(
        title: Text("Paciente(s)"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => push(context, CreateScreen()),
        child: Icon(Icons.add),


      ),
      body: StreamBuilder<List<Patient>>(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black87),
              ),
            );
          } else if (snapshot.data.length == 0){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.person),
                  SizedBox(height: 5,),
                  Text("Nenhum paciente cadastrado"),
                ],
              ),
            );
          }else{
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return patientCard(context, snapshot.data[index]);
                });
          }


        }
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _bloc = PatientBloc();

    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event e){
      print("Event $e");
      Event event = e;
      if(event.type == "paciente"){
        _bloc.fetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    subscription.cancel();
  }


}
