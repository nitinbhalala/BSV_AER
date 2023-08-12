// ignore: file_names
import 'package:bsv_app/common/colors.dart';
import 'package:bsv_app/common/custtomBtn.dart';
import 'package:bsv_app/common/images.dart';
import 'package:bsv_app/common/normal_text.dart';
import 'package:bsv_app/common/string.dart';
import 'package:bsv_app/common/widget.dart';
import 'package:bsv_app/screen/auth/sendOTP/sendOTP_controller.dart';
import 'package:bsv_app/screen/stepper/stepper_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class SendOTPScreen extends StatefulWidget {
  final String? sentotp;
  const SendOTPScreen({Key? key, this.sentotp}) : super(key: key);

  @override
  State<SendOTPScreen> createState() => _SendOTPScreenState();
}

class _SendOTPScreenState extends State<SendOTPScreen> {
  SendOTPController sendOTPController = Get.put(SendOTPController());

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: sendOTPController.formKey,
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Transform.scale(
                        scale: 1, child: SvgPicture.asset(Images.otp)),
                    SizedBox(
                      height: 7.h,
                    ),
                    NormalText(
                      txtVerificationCode,
                      fontSize: 25,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: NormalText(
                    //     txtDummy,
                    //     textAlign: TextAlign.center,
                    //     fontSize: 14,
                    //     color: AppColor.purple,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 5.h,
                    // ),
                    PinCodeTextField(
                      autoFocus: true,
                      appContext: context,
                      controller: sendOTPController.otpController,
                      pastedTextStyle: TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      animationType: AnimationType.fade,
                      backgroundColor: Colors.transparent,
                      validator: (val) => (val!.isEmpty)
                          ? 'Please Enter a OTP'
                          : (sendOTPController.otpController.text !=
                                  widget.sentotp)
                              ? 'Please Enter a Valid OTP'
                              : null,
                      pinTheme: PinTheme(
                        fieldWidth: 50,
                        fieldHeight: 45,
                        borderWidth: 0.1,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        activeColor: Color(0xFF677294),
                        selectedColor: Color(0xFF677294),
                        inactiveColor: Color(0xFF677294),
                      ),
                      cursorColor: AppColor.black,
                      animationDuration: const Duration(milliseconds: 300),
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black),
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 15.0,
                          blurStyle: BlurStyle.outer,
                          spreadRadius: 1, //New
                        )
                      ],
                      // validator: (val){
                      //   if (sendOTPController.sendOTP != sendOTPController.otpController.text) {
                      //     return 'Please Enter a valid OTP';
                      //   }
                      //   return null;
                      // },
                      onCompleted: (value) {
                        FocusScope.of(context).requestFocus(FocusNode());

                        setState(() {
                          // enterotp = value;
                        });
                        // if (sendOTPController.sendOTP == sendOTPController.otpController.text) {
                        //  return showMsg(context, msg: 'Please Enter a valid OTP', color: Colors.red);
                        // } else {
                        //   // errorMessage = 'Something went wrong, try again!';
                        // }
                      },
                      onChanged: (value) {
                        // if (value.length == 6) {
                        //   setState(() {
                        //     // isLoading = true;
                        //     // isEmpty = false;
                        //   });
                        // } else {
                        //   setState(() {
                        //     // isEmpty = true;
                        //     // isLoading = false;
                        //   });
                        // }
                      },
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    sendOTPController.isLoading
                        ? loaderButton()
                        : customButton(
                            title: txtSubmit,
                            onTap: () {
                              sendOTPAPI();
                            }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  sendOTPAPI() {
    if (sendOTPController.formKey.currentState!.validate()) {
      setState(() {
        sendOTPController.isLoading = true;
      });
      // ignore: unnecessary_null_comparison
      if (sendOTPController.otpController.text != null) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            setState(() {
              sendOTPController.isLoading = false;
              Get.to(const StepperScreen());
            });
          },
        );
      } else {
        showMsg(context, msg: 'Please Enter a OTP');
        Future.delayed(
          const Duration(seconds: 2),
          () {
            setState(() {
              sendOTPController.isLoading = false;
            });
          },
        );
      }
    }
  }
}
