import 'package:bsv_app/screen/auth/login/login_page.dart';
import 'package:bsv_app/screen/stepper/stepper_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  String token = '';
  String phone = '';

  @override
  void onInit() {
    getLocalData();
    super.onInit();
  }

  void getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    phone = prefs.getString("phone") ?? '';
    print("CLAIM PAGE TOKEN");
    print(phone);
    splash();
  }

  void splash() async {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (phone == '') {
          Get.to(const LoginScreen());
        } else {
          // Get.to(const LoginScreen());
          Get.to(const StepperScreen());
        }
      },
    );
  }
}
