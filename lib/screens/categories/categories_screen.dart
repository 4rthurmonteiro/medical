import 'package:flutter/material.dart';
import 'package:medical/screens/categories/equations_screen.dart';
import 'package:medical/utils/nav.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
      ),

      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index){
            return GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                                  // MediaQuery.of(context).size.width - 300
                                  child: Text(
                                    "Cardiologia", style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Divider(
                          thickness: 1.0,
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () => push(context, EquationsScreen()));
          }),
    );
  }
}
