import 'package:bsv_app/screen/stepper/stepper_page.dart';
import 'package:get/get.dart';

class SuccessFullController extends GetxController {
  @override
  void onInit() {
    getLocalData();
    super.onInit();
  }

  void getLocalData() async {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Get.to(const StepperScreen());
      },
    );
  }
}
