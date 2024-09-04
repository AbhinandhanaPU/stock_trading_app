import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastGreen({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.green.withOpacity(0.5),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showToastRed({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.red.withOpacity(0.6),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
