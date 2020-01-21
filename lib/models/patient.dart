import 'package:medical/models/entity.dart';

final String idColumn = "id";
final String nameColumn = "nome";
final String dayBirthColumn = "dataNascimento";
final String genderColumn = "genero";
final String emailColumn = "email";
final String phoneColumn = "telefone";

final String patientTable = "Pacientes";

class Patient extends Entity {

  int id;
  String name;
  String dayBirth;
  String gender;
  String email;
  String phone;

  Patient({this.id, this.name, this.dayBirth, this.gender, this.email, this.phone});

  factory Patient.fromJson(Map<String, dynamic> json){
    return Patient(
      id: json[idColumn],
      name: json[nameColumn],
      dayBirth: json[dayBirthColumn],
      gender: json[genderColumn],
      email: json[emailColumn],
      phone: json[phoneColumn]
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[idColumn] = this.id;
    data[nameColumn] = this.name;
    data[dayBirthColumn] = this.dayBirth;
    data[genderColumn] = this.gender;
    data[emailColumn] = this.email;
    data[phoneColumn] = this.phone;

    return data;
  }

  @override
  String toString() {
    return 'Patient{id: $id, name: $name, dayBirth: $dayBirth, gender: $gender, email: $email, phone: $phone}';
  }


}