import 'package:flutter/material.dart';
import 'package:medical/models/result.dart';

Widget resultCard(BuildContext context, Result item){
  return GestureDetector(
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white70,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(item.equation ?? ""),
                      GestureDetector(
                          child: Icon(Icons.picture_as_pdf,
                          ),
                      onTap: () => print("pdf"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Categoria: "),
                      Text(item.category),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Resultado: "),
                      Text(item.result),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    ),
  );
}