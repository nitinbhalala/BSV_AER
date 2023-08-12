import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

save(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

void showMsg(BuildContext context, {String? msg, Color? color}) {
  Fluttertoast.showToast(
    msg: msg!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: color ?? Colors.black.withOpacity(0.3),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}