import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical/models/result.dart';
import 'package:medical/repository/result_repository.dart';
import 'package:rxdart/rxdart.dart';

class MeanBloodPressureBloc extends BlocBase {

  final _resultRepository = ResultRepository();

  final _dataController = BehaviorSubject<Result>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();


  Stream<Result> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  Result unsavedData = new Result();

  final int patientId;

  MeanBloodPressureBloc({@required this.patientId}){

    _createdController.add(false);

    unsavedData.patientId = patientId;

   _dataController.add(unsavedData);
  }

  Future<bool> save(String result) async {

    _loadingController.add(true);



    try {

      unsavedData.equation = "PAM (Pressão arterial média)";
      unsavedData.result = result + " mmHg";
      unsavedData.category = "Cardiologia";
      unsavedData.resultValue = "Hipertensão arterial acontece quando a nossa pressão está acima do limite considerado normal, que, na média, é máxima em 120 e mínima em 80 milímetros de mercúrio, ou simplesmente 12 por 8. Valores inferiores a 14 por 9 podem ser considerados normais a critério médico. As pessoas que têm familiares hipertensos, que não têm hábitos alimentares saudáveis, ingerem muito sal, estão acima do peso, exageram no consumo de álcool ou são diabéticas têm mais risco de desenvolver a hipertensão.";
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



  String equation(String pas, String pad){
     try{

       double value1 = double.parse(pas);
       double value2 = double.parse(pad);

        double value = (value1 + 2*value2)/3;

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
