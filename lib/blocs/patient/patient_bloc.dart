import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:medical/models/patient.dart';
import 'package:medical/repository/patient_repository.dart';
import 'package:rxdart/rxdart.dart';

class PatientBloc extends BlocBase {

  final _patientRepository = PatientRepository();

  final _patientController = BehaviorSubject<List<Patient>>();

  Stream<List<Patient>> get stream => _patientController.stream;

  PatientBloc(){
    fetch();
  }

  Future<List<Patient>> fetch() async{

    print("Fetching a lista de pacientes...");

    List<Patient> _patients = [];

    try{
      _patients = await _patientRepository.findAll();

      _patientController.add(_patients);

      return _patients;
    } catch (e){
      if(!_patientController.isClosed){
        _patientController.addError(e);
      }

      return null;
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _patientController.close();
  }

}