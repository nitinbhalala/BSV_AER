import 'dart:convert';
import 'package:bsv_app/screen/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController{

  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  var dropdownValue ;

  // List of items in our dropdown menu
  var items = [
    'Patient',
    'Doctor',
  ];

  bool password = false;
  passwordHide(context){
    password =! password;
    update();
  }

  bool confirmPassword = false;
  confirmPasswordHide(context){
    confirmPassword =! confirmPassword;
    update();
  }

  Future signUpAPI() async {
    String url = "${baseUrl}app-register";
    var response = await http.post(
        headers: {"Content-Type": "application/json"},
        Uri.parse(url),
        body: jsonEncode({
          "first_name": firstNameController.text,
          "last_name":lastNameController.text,
          "phone":phoneNumberController.text,
          "email":emailController.text,
          "password":passwordController.text,
          "user_type": dropdownValue.toString(),
        })
    );
    var model = jsonDecode(response.body);
    return model;
  }
}