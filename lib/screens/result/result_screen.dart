import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medical/blocs/result/result_bloc.dart';
import 'package:medical/event_bus/event_bus.dart';
import 'package:medical/models/event.dart';
import 'package:medical/models/patient.dart';
import 'package:medical/models/result.dart';
import 'package:medical/screens/categories/categories_screen.dart';
import 'package:medical/screens/result/result_card.dart';
import 'package:medical/utils/nav.dart';

class ResultScreen extends StatefulWidget {
  final Patient patient;

  ResultScreen({@required this.patient});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  Patient get patient => widget.patient;

  StreamSubscription<Event> subscription;

  ResultBloc _bloc;


  @override
  void initState() {
    super.initState();
    _bloc = ResultBloc(patientId: patient.id);

    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event e){
      print("Event $e");
      Event event = e;
      if(event.type == "resultado"){
        _bloc.fetch(patient.id);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    subscription.cancel();
  }

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
      body: StreamBuilder<List<Result>>(
        stream: _bloc.stream,
        builder: (context, snapshot){
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
                  Icon(Icons.assignment),
                  SizedBox(height: 5,),
                  Text("Nenhum resultado cadastrado"),
                ],
              ),
            );
          }else{
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return resultCard(context, snapshot.data[index]);
                });
          }
        },
      )
    );
  }
}
