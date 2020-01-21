import 'package:medical/dao/result_dao.dart';
import 'package:medical/models/result.dart';

class ResultRepository {
  final _resultDao = ResultDao();

  Future<int> save(Result result) => _resultDao.save(result);

  Future<List<Result>> findAll() => _resultDao.findAll();

  Future<Result> findById(int id) => _resultDao.findById(id);

  Future<int> deleteAll() => _resultDao.deleteAll();

  Future<List<Result>> findByPatient(int patientId) =>
      _resultDao.findByPatient(patientId);
}
