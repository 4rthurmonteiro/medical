import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical/models/result.dart';
import 'package:medical/repository/result_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/patient.dart';
import '../../../repository/patient_repository.dart';

class TidalVolumeBloc extends BlocBase {

  final _resultRepository = ResultRepository();
  final _patientRepository = PatientRepository();

  final _dataController = BehaviorSubject<Result>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();


  Stream<Result> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  Result unsavedData = new Result();

  final int patientId;

  TidalVolumeBloc({@required this.patientId}){

    _createdController.add(false);

    unsavedData.patientId = patientId;

   _dataController.add(unsavedData);
  }

  Future<bool> save(String result) async {

    _loadingController.add(true);



    try {

      unsavedData.equation = "Volume Corrente";
      unsavedData.result = result + " ml/kg";
      unsavedData.category = "Pulmonar";
      unsavedData.resultValue = "O volume corrente é o volume pulmonar que representa o volume normal do ar circulado entre uma inalação e exalação normal, sem um esforço suplementar. O valor do volume corrente de um adulto saudável é de aproximadamente 500 ml por inspiração ou 7 ml/kg de massa corporal.";
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

  Future<String> equation(String altura) async {

    Patient patient = await _patientRepository.findById(patientId);

     try{

       double value1 = double.parse(altura);

       double value;

       if(patient.gender == "M"){
         value = 50 + (0.91 * (value1 - 152.4));
       }else{
         value = 45.5 + (0.91 *(value1 - 152.4));
       }

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
