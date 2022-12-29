import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        // ignore: unrelated_type_equality_checks
        backgroundColor:  ThemeMode == ThemeMode.light ?  Colors.green : Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
