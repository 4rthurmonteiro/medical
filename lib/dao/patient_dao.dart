import 'package:medical/dao/base_dao.dart';
import 'package:medical/models/patient.dart';

class PatientDao extends BaseDao<Patient> {
  @override
  fromJson(Map<String, dynamic> map) {
    // TODO: implement fromJson
    return Patient.fromJson(map);
  }

  @override
  // TODO: implement tableName
  String get tableName => patientTable;

}