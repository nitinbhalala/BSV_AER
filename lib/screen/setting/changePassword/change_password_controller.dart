import 'dart:convert';

import 'package:bsv_app/screen/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String token = '';
  bool isLoading = false;
  bool password = false;
  passwordHide(context) {
    password = !password;
    update();
  }

  @override
  void onInit() {
    //  getLocalData();
    super.onInit();
  }

  bool confirmPassword = false;
  confirmPasswordHide(context) {
    confirmPassword = !confirmPassword;
    update();
  }

  Future changePassword() async {
    String url = "${baseUrl}change-password";
    var response = await http.post(
        headers: {"Content-Type": "application/json"},
        Uri.parse(url),
        body: jsonEncode({
          "current_password": oldPasswordController.text,
          "new_password": newPasswordController.text,
        }));
    print("Response Body :~ ${response.body}");
    var model = jsonDecode(response.body);
    return model;
  }
}
