import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical/models/result.dart';
import 'package:medical/repository/result_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/patient.dart';
import '../../../repository/patient_repository.dart';

class CstBloc extends BlocBase {

  final _resultRepository = ResultRepository();

  final _dataController = BehaviorSubject<Result>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();


  Stream<Result> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  Result unsavedData = new Result();

  final int patientId;

  CstBloc({@required this.patientId}){

    _createdController.add(false);

    unsavedData.patientId = patientId;

   _dataController.add(unsavedData);
  }

  Future<bool> save(String result) async {

    _loadingController.add(true);



    try {

      unsavedData.equation = "CST (Complacência estática)";
      unsavedData.result = result + " ml/cmH2O";
      unsavedData.category = "Pulmonar";
      unsavedData.resultValue = "Valor habitual: 50 a 80 ml/cmH2O. Alta – Enfisema. Baixa – SARA, edema pulmonar, distensão abdominal, pneumotórax.";
      unsavedData.dateResult = DateTime.now().toIso8601String();
      unsavedData.professional = "Doutor";

      bool success =
      await _resultRepository.save(unsavedData) == null ? false : true;

      _createdController.add(true);
      _loadingController.add(false);

      return success;
    } catch (e) {
      _loadingController.add(false);

      return false;
    }


  }

  String equation(String vc, String ppausa, String peep) {


     try{

       double value1 = double.parse(vc);
       double value2 = double.parse(ppausa);
       double value3 = double.parse(peep);

       double value = value1/(value2 - value3);

       return value.toStringAsFixed(1);

      }catch(e){
        print(e);
        return "";
      }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dataController.close();
    _loadingController.close();
    _createdController.close();
  }
}
