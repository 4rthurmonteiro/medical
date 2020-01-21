import 'package:bloc_pattern/bloc_pattern.dart';
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

  MeanBloodPressureBloc(){

    _createdController.add(false);

   _dataController.add(unsavedData);
  }

  Future<bool> save() async {
    return false;
  }

  void savePAS(String value){

  }

  void savePAD(String value){

  }


  @override
  void dispose() {
    // TODO: implement dispose
    _dataController.close();
    _loadingController.close();
    _createdController.close();
  }
}
