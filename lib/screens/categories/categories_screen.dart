import 'package:flutter/material.dart';
import 'package:medical/screens/categories/cards/cardio_card.dart';
import 'package:medical/screens/equations/equations_screen.dart';
import 'package:medical/utils/nav.dart';

import 'cards/pulmonary_card.dart';

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
      body: Column(
        children: <Widget>[
          cardioCard(context),
          pulmonaryCard(context)

        ],
      ),
    );
  }
}
