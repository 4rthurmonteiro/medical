import 'package:flutter/material.dart';
import 'package:medical/models/event.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class EventBus {

  final _streamController = BehaviorSubject<Event>();

  Stream<Event> get stream => _streamController.stream;

  sendEvent(Event event){
    _streamController.add(event);
  }

  dispose(){
    _streamController.close();
  }

  static get(BuildContext context) => Provider.of<EventBus>(context, listen: false);

}