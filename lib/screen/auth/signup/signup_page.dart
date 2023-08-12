import 'package:bsv_app/common/colors.dart';
import 'package:bsv_app/common/custtomBtn.dart';
import 'package:bsv_app/common/images.dart';
import 'package:bsv_app/common/normal_text.dart';
import 'package:bsv_app/common/string.dart';
import 'package:bsv_app/common/textField.dart';
import 'package:bsv_app/common/widget.dart';
import 'package:bsv_app/screen/auth/login/login_page.dart';
import 'package:bsv_app/screen/auth/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  SignUpController signupController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.bg), fit: BoxFit.fill)),
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: signupController.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.scale(
                            scale: 0.7,
                            child: Image.asset(Images.logo)),
                        SizedBox(
                          height: 4.h,
                        ),
                        NormalText(
                          txtWlcBSV,
                          fontSize: 24,
                          color: AppColor.black,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: NormalText(
                              txtDummy,
                              textAlign: TextAlign.center,
                              fontSize: 14,
                              color: AppColor.purple,
                            )),
                        SizedBox(
                          height: 4.h,
                        ),
                        NormalText(
                          txtSignup,
                          fontSize: 25,
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        textField(
                          controller: signupController.firstNameController,
                            validator: (val){
                              if(val == null || val.isEmpty){
                                return 'Please enter your First name';
                              }
                            },
                            hint: 'First name',
                            textInputAction: TextInputAction.next),
                        textField(
                            controller: signupController.lastNameController,
                            validator: (val){
                              if(val == null || val.isEmpty){
                                return 'Please enter your Last name';
                              }
                            },
                            hint: 'Last name',
                            textInputAction: TextInputAction.next),
                        textField(
                            controller: signupController.emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val){
                              if(val == null || val.isEmpty){
                                return 'Please enter your email';
                              }else if (!val.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            hint: 'Email address',
                            textInputAction: TextInputAction.next),
                        textField(
                            controller: signupController.phoneNumberController,
                            length: 10,
                            keyboardType: TextInputType.number,
                            hint: 'Mobile number',
                            validator: (val){
                              if(val == null || val.isEmpty){
                                return 'Please enter your Phone number';
                              }else if(val.length < 10 ){
                                return 'Please enter 10 digits';
                              }
                            },
                            textInputAction: TextInputAction.next),
                        textField(
                            controller: signupController.passwordController,
                            validator: (val){
                              if(val == null || val.isEmpty){
                                return 'Please enter your password';
                              }else if(val.length < 6){
                                return 'Must be more than 6 character';
                              }return null;
                            },
                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signupController.passwordHide(context);
                                setState(() {});
                              },
                              child: Transform.scale(
                                  scale: 0.6,
                                  child: signupController.password
                                      ? SvgPicture.asset(Images.eyesOpen)
                                      : SvgPicture.asset(Images.eyesClose)),
                            ),
                            hint: 'Password',
                            obscureText: signupController.password),
                        textField(
                            controller: signupController.confirmPasswordController,
                            validator: (val){
                              if(val == null || val.isEmpty){
                                return 'Please enter your password';
                              }else if(val != signupController.passwordController.text)
                              {
                                return "Both password not match Please check a password";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.done,
                            maxLines: 1,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signupController.confirmPasswordHide(context);
                                setState(() {});
                              },
                              child: Transform.scale(
                                  scale: 0.6,
                                  child: signupController.confirmPassword
                                      ? SvgPicture.asset(Images.eyesOpen)
                                      : SvgPicture.asset(Images.eyesClose)),
                            ),
                            hint: 'Confirm password',
                            obscureText: signupController.confirmPassword),
                        SizedBox(height: 1.h,),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColor.lightPurple)
                          ),
                          child: Center(
                            child: DropdownButton(
                              value: signupController.dropdownValue,
                              isExpanded: true,
                              underline: const SizedBox(),
                              isDense: true,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              hint: Text("userType",style: TextStyle(color: AppColor.purple),),
                              items: signupController.items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: NormalText(items, fontSize: 15, color: AppColor.purple),
                                );
                              }).toList(),
                              onChanged: ( newValue) {
                                setState(() {
                                  signupController.dropdownValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                      signupController.isLoading ? loaderButton() : customButton(title: txtSignup,onTap: (){
                          signUp();
                          // Get.to(const LoginScreen());
                        }),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NormalText(txtAlreadyAC, fontSize: 14, color: AppColor.black),
                            GestureDetector(
                                onTap: (){
                                  Get.to(const LoginScreen());
                                },
                                child: NormalText(txtLogIn, fontSize: 14, color: AppColor.primary)),
                          ],
                        ),
                        SizedBox(height: 2.h,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  signUp() async {
    if (signupController.formKey.currentState!.validate()) {
      setState(() {
        signupController.isLoading = true;
      });
      if(signupController.dropdownValue != null)
        {
          signupController.signUpAPI().then((res) {
            if (res['status']){
              showMsg(context, msg: res['message'], color: Colors.green);
              Get.to(const LoginScreen());
              // save("api_token", res['api_token']);
              // save("first_name", model['first_name']);
            }else{
              showMsg(context, msg: res['message'], color: Colors.red);
            }
          });
        }else{
        showMsg(context, msg: 'Please select a usertype', color: Colors.red);
      }
    }
    Future.delayed(
      const Duration(seconds: 2),
          () {
        setState(() {
          signupController.isLoading = false;
        });
      },
    );
  }
}

