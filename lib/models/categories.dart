import 'entity.dart';

final String idColumn = "id";
final String nameColumn = "nome";

final String categoriesTable = "Categorias";

class Categories extends Entity {

  int id;
  String name;

  Categories({this.id, this.name});

  factory Categories.fromJson(Map<String, dynamic> json){
    return Categories(
      id: json[idColumn],
      name: json[nameColumn]
    );
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[idColumn] = this.id;
    data[nameColumn] = this.name;

    return data;
  }

  @override
  String toString() {
    return 'Categories{id: $id, name: $name}';
  }


}