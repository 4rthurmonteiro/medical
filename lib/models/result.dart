import 'entity.dart';

final String idColumn = "id";
final String patientIdColumn = "pacienteId";
final String categoryColumn = "categoria";
final String professionalColumn = "profissional";
final String resultValueColumn = "resultadoValor";
final String resultColumn = "resultado";

final String resultTable = "Resultados";

class Result extends Entity {

  int id;
  int patientId;
  String category;
  String professional;
  String resultValue;
  String result;

  Result({this.id, this.patientId, this.category, this.professional, this.resultValue, this.result});

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      id: json[idColumn],
      patientId: json[patientIdColumn],
      category: json[categoryColumn],
      professional: json[professionalColumn],
      resultValue: json[resultValueColumn],
      result: json[resultColumn]
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[idColumn] = this.id;
    data[patientIdColumn] = this.patientId;
    data[categoryColumn] = this.category;
    data[professionalColumn] = this.professional;
    data[resultValueColumn] = this.resultValue;
    data[resultColumn] = this.result;
    return data;
  }

  @override
  String toString() {
    return 'Result{id: $id, patientId: $patientId, category: $category, professional: $professional, resultValue: $resultValue, result: $result}';
  }
}