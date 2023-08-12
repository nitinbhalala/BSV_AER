import 'package:bsv_app/common/colors.dart';
import 'package:bsv_app/common/custtomBtn.dart';
import 'package:bsv_app/common/images.dart';
import 'package:bsv_app/common/normal_text.dart';
import 'package:bsv_app/common/string.dart';
import 'package:bsv_app/common/textField.dart';
import 'package:bsv_app/common/widget.dart';
import 'package:bsv_app/screen/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  @override
  void initState() {
    changePasswordController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Images.bg),
          fit: BoxFit.fill,
        )),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: changePasswordController.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(Images.backArrow),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      NormalText(
                        txtChangePassword,
                        fontSize: 18,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                      Container(width: 25),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Transform.scale(scale: 0.8, child: Image.asset(Images.logo)),
                  SizedBox(
                    height: 5.h,
                  ),
                  textField(
                      controller:
                          changePasswordController.oldPasswordController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your password';
                        } else if (val.length < 6) {
                          return 'Must be more than 6 character';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      hint: 'Old Password'),
                  textField(
                      controller:
                          changePasswordController.newPasswordController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your password';
                        } else if (val.length < 6) {
                          return 'Must be more than 6 character';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          changePasswordController.passwordHide(context);
                          setState(() {});
                        },
                        child: Transform.scale(
                            scale: 0.6,
                            child: changePasswordController.password
                                ? SvgPicture.asset(Images.eyesOpen)
                                : SvgPicture.asset(Images.eyesClose)),
                      ),
                      hint: 'New Password',
                      obscureText: changePasswordController.password),
                  textField(
                      controller:
                          changePasswordController.confirmPasswordController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your password';
                        } else if (val !=
                            changePasswordController
                                .newPasswordController.text) {
                          return "Both password not match Please check a password";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          changePasswordController.confirmPasswordHide(context);
                          setState(() {});
                        },
                        child: Transform.scale(
                            scale: 0.6,
                            child: changePasswordController.confirmPassword
                                ? SvgPicture.asset(Images.eyesOpen)
                                : SvgPicture.asset(Images.eyesClose)),
                      ),
                      hint: 'Confirm password',
                      obscureText: changePasswordController.confirmPassword),
                  changePasswordController.isLoading
                      ? loaderButton()
                      : customButton(
                          title: txtUpdate,
                          onTap: () {
                            changePassword();
                          }),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  changePassword() async {
    if (changePasswordController.formKey.currentState!.validate()) {
      setState(() {
        changePasswordController.isLoading = true;
      });
      changePasswordController.changePassword().then((value) {
        print("res $value");
        if (value['status']) {
          print("success msg:~ $value");
          showMsg(context, msg: value['message'], color: Colors.green);
          Get.to(const SettingScreen());
        } else {
          print("error msg:~ $value");
          showMsg(context, msg: value['message'], color: Colors.red);
        }
      });
    }
    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          changePasswordController.isLoading = false;
        });
      },
    );
  }
}
