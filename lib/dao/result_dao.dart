import 'package:medical/models/result.dart';

import 'base_dao.dart';

class ResultDao extends BaseDao<Result> {
  @override
  Result fromJson(Map<String, dynamic> map) {
    // TODO: implement fromJson
    return Result.fromJson(map);
  }

  @override
  // TODO: implement tableName
  String get tableName => resultTable;

  Future<List<Result>> findByPatient(int patientId) async {
    List<Result> list = await query(
        'select * from $tableName where $patientIdColumn = ?', [patientId]);

    return list.length > 0 ? list : [];
  }
}