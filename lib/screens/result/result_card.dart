import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical/models/result.dart';

Widget resultCard(BuildContext context, Result item){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: ExpansionTile(
        title: Text(item.equation ?? ""),
        leading: Icon(Icons.assignment),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  title: Text("Categoria"),
                  subtitle: Text(item.category ?? ""),

                ),
                ListTile(
                  title: Text("Profissional da saúde"),
                  subtitle: Text(item.professional ?? ""),

                ),
                ListTile(
                  title: Text("Data do resuiltado"),
                  subtitle: Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(item.dateResult) ?? "")),
                ),
                ListTile(
                  title: Text("Resultado"),
                  subtitle: Text(item.result ?? ""),

                ),
                ListTile(
                  title: Text("Observações"),
                  subtitle: Text(item.resultValue ?? ""),

                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}