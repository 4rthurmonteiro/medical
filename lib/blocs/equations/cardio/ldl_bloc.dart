import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical/models/result.dart';
import 'package:medical/repository/result_repository.dart';
import 'package:rxdart/rxdart.dart';

class LdlBloc extends BlocBase {

  final _resultRepository = ResultRepository();

  final _dataController = BehaviorSubject<Result>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();


  Stream<Result> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  Result unsavedData = new Result();

  final int patientId;

  LdlBloc({@required this.patientId}){

    _createdController.add(false);

    unsavedData.patientId = patientId;

   _dataController.add(unsavedData);
  }

  Future<bool> save(String result) async {

    _loadingController.add(true);



    try {

      unsavedData.equation = "LDL-Colesterol";
      unsavedData.result = result + " mg/dL";
      unsavedData.category = "Cardiologia";
      unsavedData.resultValue = "O LDL-colesterol pode ser calculado a partir do colesterol total, HDL-colesterol e triglicerídeos ou VLDL (VLDL-colesterol corresponde a TG/5). Entretanto, esta fórmula torna-se imprecisa na vigência de hipertrigliceridemia (triglicerídeos>400mg/dL), hepatopatia colestática crônica ou síndrome nefrótica, quando não deve ser utilizada.";
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



  String equation(String ct, String hdl, String tg){
     try{

       double value1 = double.parse(ct);
       double value2 = double.parse(hdl);
       double value3 = double.parse(tg);

        double value = value1 - value2 - value3/3;

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
