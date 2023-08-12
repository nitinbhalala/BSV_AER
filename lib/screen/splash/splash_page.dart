import 'package:bsv_app/common/images.dart';
import 'package:bsv_app/screen/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    splashController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Images.bg),
          fit: BoxFit.fill,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.logo),
              // SizedBox(height: 2.h,),
              // NormalText(txtAppName, fontSize: 34, color: AppColor.black,fontWeight: FontWeight.bold,),
            ],
          ),
        ),
      ),
    );
  }
}
