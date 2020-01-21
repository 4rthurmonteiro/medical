import 'package:flutter/material.dart';
import 'package:medical/utils/colors.dart';

InputDecoration textFormFieldDecoration({@required String label,@required IconData icon}) {
  return InputDecoration(
    border:
    OutlineInputBorder(borderSide: new BorderSide(color: textColor)),
    labelText: label,
    prefixIcon: Icon(
      icon,
      color: Colors.black26,
    ),
  );
}