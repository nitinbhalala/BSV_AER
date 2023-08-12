import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SendOTPController extends GetxController {
  TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int sendOTP = 123456;
  bool isLoading = false;
}
