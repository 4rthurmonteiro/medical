import 'entity.dart';

final String idColumn = "id";
final String patientIdColumn = "pacienteId";
final String categoryColumn = "categoria";
final String professionalColumn = "profissional";
final String resultValueColumn = "resultadoValor";
final String resultColumn = "resultado";
final String equationColumn = "equacao";
final String dateResultColumn = "dataResultado";

final String resultTable = "Resultados";

class Result extends Entity {

  int id;
  int patientId;
  String equation;
  String category;
  String professional;
  String resultValue;
  String result;
  String dateResult;

  Result({this.id, this.patientId, this.equation,this.category, this.professional, this.resultValue, this.result, this.dateResult});

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      id: json[idColumn],
      patientId: json[patientIdColumn],
      equation: json[equationColumn],
      category: json[categoryColumn],
      professional: json[professionalColumn],
      resultValue: json[resultValueColumn],
      result: json[resultColumn],
      dateResult: json[dateResultColumn]
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[idColumn] = this.id;
    data[patientIdColumn] = this.patientId;
    data[equationColumn] = this.equation;
    data[categoryColumn] = this.category;
    data[professionalColumn] = this.professional;
    data[resultValueColumn] = this.resultValue;
    data[resultColumn] = this.result;
    data[dateResultColumn] = this.dateResult;

    return data;
  }

  @override
  String toString() {
    return 'Result{id: $id, patientId: $patientId, category: $category, professional: $professional, resultValue: $resultValue, result: $result}';
  }
}