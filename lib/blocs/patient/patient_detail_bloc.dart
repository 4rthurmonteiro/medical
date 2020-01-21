import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:medical/models/patient.dart';
import 'package:medical/repository/patient_repository.dart';
import 'package:rxdart/rxdart.dart';

class PatientDetailBloc extends BlocBase {
  final _patientRepository = PatientRepository();

  final _dataController = BehaviorSubject<Patient>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();

  Stream<Patient> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  final Patient patient;

  Patient unsavedData = new Patient();

  PatientDetailBloc({this.patient}) {
    if (patient != null) {
      unsavedData = patient;
      _createdController.add(true);
    } else {
      _createdController.add(false);
    }
    _dataController.add(unsavedData);
  }

  void saveName(String value) {
    unsavedData.name = value;
  }

  void saveDayBirth(DateTime value) {
    unsavedData.dayBirth = value.toIso8601String();
  }

  void saveGender(String value) {
    unsavedData.gender = value;
  }

  void saveEmail(String value) {
    unsavedData.email = value;
  }

  void savePhone(String value) {
    unsavedData.phone = value;
  }

  Future<bool> savePatient() async {
    _loadingController.add(true);

    try {
      bool success =
          await _patientRepository.save(unsavedData) == null ? false : true;

      _createdController.add(true);
      _loadingController.add(false);

      return success;
    } catch (e) {
      _loadingController.add(false);

      return false;
    }
  }

  Future<bool> deletePatient() async {
    _loadingController.add(true);

    try {
      bool success = await _patientRepository.delete(patient.id) == null ? false : true;
      _loadingController.add(false);
      return success;
    } catch (e) {
      _loadingController.add(false);

      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dataController.close();
    _loadingController.close();
    _createdController.close();
  }

  @override
  String toString() {
    return 'PatientDetailBloc{_patientRepository: $_patientRepository, _dataController: $_dataController, _loadingController: $_loadingController, _createdController: $_createdController, patient: $patient, unsavedData: $unsavedData}';
  }
}
