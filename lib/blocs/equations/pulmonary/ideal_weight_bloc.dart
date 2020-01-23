import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical/models/result.dart';
import 'package:medical/repository/result_repository.dart';
import 'package:rxdart/rxdart.dart';

class ImcBloc extends BlocBase {

  final _resultRepository = ResultRepository();

  final _dataController = BehaviorSubject<Result>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();


  Stream<Result> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  Result unsavedData = new Result();

  final int patientId;

  ImcBloc({@required this.patientId}){

    _createdController.add(false);

    unsavedData.patientId = patientId;

   _dataController.add(unsavedData);
  }


  String resultFunc(String value){

    try{

      double value1 = double.parse(value);

      if(value1 < 18.5){
        return "Abaixo do Peso";
      }else if(value1 >= 18.5 && value1 <= 24.9){
        return "Peso Normal";
      }else if(value1 >= 25 && value1 <= 29.9){
        return "Sobrepeso";
      }else if(value1 >= 30 && value1 <= 34.9){
        return "Obesidade";
      }else if(value1 >= 35 && value1 <= 39.9){
        return "Obesidade Moderada";
      }else if(value1 >= 40 && value1 <= 49.9){
        return "Obesidade Severa";
      }else {
        return "Obesidade Mórbida";
      }

    }catch(e){
      return "Erro no cálculo";
    }


  }

  Future<bool> save(String result) async {

    _loadingController.add(true);



    try {

      unsavedData.equation = "IMC (Íncide de Massa Corporal)";
      unsavedData.result = result;
      unsavedData.category = "Cardiologia";
      unsavedData.resultValue = resultFunc(result);
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



  String equation(String peso, String altura){
     try{

       double value1 = double.parse(peso);
       double value2 = double.parse(altura);

        double value = value1/(value2*value2);

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
