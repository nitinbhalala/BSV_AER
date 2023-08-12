import 'dart:convert';
import 'package:bsv_app/screen/stepper/stepper_controller.dart';
import 'package:http/http.dart' as http;
import 'package:bsv_app/screen/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  StepperController stepperController = Get.put(StepperController());
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  bool isLoading = false;
  bool password = false;
  bool isOther = false;

  passwordHide(context) {
    password = !password;
    update();
  }

  var dropdownValue;
  var items = [
    'Doctor',
    'Nurse',
    'Patient',
    'Other',
  ];

  Future loginAPI() async {
    String url = "${baseUrl}app-login";
    var response = await http.post(
        headers: {"Content-Type": "application/json"},
        Uri.parse(url),
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }));
    print("Response Body :~ ${response.body}");
    var model = jsonDecode(response.body);
    return model;
  }
}
