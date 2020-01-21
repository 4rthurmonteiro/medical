import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical/models/result.dart';
import 'package:medical/repository/result_repository.dart';
import 'package:rxdart/rxdart.dart';

class ResultBloc extends BlocBase {
  final _resultRepository = ResultRepository();

  final _resultController = BehaviorSubject<List<Result>>();

  Stream<List<Result>> get stream => _resultController.stream;

  final int patientId;

  ResultBloc({@required this.patientId}) {
    fetch(patientId);
  }

  Future<List<Result>> fetch(int patientId) async {
    print("Fetching a lista de resultados...");

    List<Result> _results = [];

    try {
      _results = await _resultRepository.findByPatient(patientId);

      _resultController.add(_results);

      return _results;
    } catch (e) {
      if(!_resultController.isClosed){
        _resultController.addError(e);
      }

      return null;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _resultController.close();
  }
}
