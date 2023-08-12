import 'dart:convert';

import 'package:bsv_app/screen/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  bool isLoading = false;
  bool isOther = false;
  String token = '';
  String phone = '';
  String usertype = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String otherUserType = '';
  var dropdownValue;

  // List of items in our dropdown menu
  var items = [
    'Doctor',
    'Nurse',
    'Patient',
    'Other',
  ];

  @override
  void onInit() {
    print("okokok : 1");
    getLocalData();
    super.onInit();
  }

  void getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    phone = prefs.getString("phone")!;
    usertype = prefs.getString("user_type")!;
    firstName = prefs.getString("first_name")!;
    print("okokok : $firstName");
    lastName = prefs.getString("last_name")!;
    email = prefs.getString("email")!;
    otherUserType = prefs.getString("other_type")!;
    dropdownValue = prefs.getString("user_type");
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    phoneController.text = phone;
    emailController.text = email;
    update();
    print("CLAIM PAGE TOKEN");
    print(token);
    print(firstNameController.text);
    print(lastName);
    print(email);
    print(phone);
    print(dropdownValue.toString());
  }

  Future editProfile() async {
    String url = "${baseUrl}edit-profile";
    var response = await http.post(
        headers: {"Content-Type": "application/json", "token": token},
        Uri.parse(url),
        body: jsonEncode({
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "phone": phoneController.text,
          "email": emailController.text,
          "user_type": dropdownValue.toString(),
        }));
    print("Response Body :~ ${response.body}");
    var model = jsonDecode(response.body);
    return model;
  }
}
