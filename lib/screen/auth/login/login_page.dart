import 'dart:convert';

import 'package:bsv_app/common/colors.dart';
import 'package:bsv_app/common/custtomBtn.dart';
import 'package:bsv_app/common/images.dart';
import 'package:bsv_app/common/normal_text.dart';
import 'package:bsv_app/common/string.dart';
import 'package:bsv_app/common/textField.dart';
import 'package:bsv_app/common/widget.dart';
import 'package:bsv_app/screen/auth/sendOTP/sendOTP_page.dart';
import 'package:bsv_app/screen/constants.dart';
import 'package:bsv_app/screen/setting/terms_conditions/terms_and_conditions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Images.bg),
          fit: BoxFit.fill,
        )),
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 1),
              child: Form(
                key: loginController.formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Transform.scale(
                                scale: 0.7, child: Image.asset(Images.logo)),
                            SizedBox(
                              height: 4.h,
                            ),
                            NormalText(
                              txtWlcBack,
                              fontSize: 18,
                              color: AppColor.black,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.center,
                            ),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            // Container(
                            //     padding:
                            //         const EdgeInsets.symmetric(horizontal: 20),
                            //     child: NormalText(
                            //       txtDummy,
                            //       textAlign: TextAlign.center,
                            //       fontSize: 14,
                            //       color: AppColor.purple,
                            //     )),
                            SizedBox(
                              height: 4.h,
                            ),
                            NormalText(
                              txtLogIn,
                              fontSize: 25,
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            textField(
                                controller: loginController.firstNameController,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter your Full name';
                                  }
                                },
                                hint: 'Full name',
                                textInputAction: TextInputAction.next),
                            // textField(
                            //     controller: loginController.lastNameController,
                            //     validator: (val) {
                            //       if (val == null || val.isEmpty) {
                            //         return 'Please enter your Last name';
                            //       }
                            //     },
                            //     hint: 'Last name',
                            //     textInputAction: TextInputAction.next),
                            textField(
                                controller: loginController.emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!val.contains('@')) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                hint: 'Email address',
                                textInputAction: TextInputAction.next),
                            textField(
                                controller:
                                    loginController.phoneNumberController,
                                keyboardType: TextInputType.phone,
                                length: 10,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Please enter your phone';
                                  } else if (val.length != 10) {
                                    return "Please enter min 10 digits";
                                  }
                                  return null;
                                },
                                hint: 'Phone Number',
                                textInputAction: TextInputAction.done),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 44,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: AppColor.lightPurple)),
                              child: Center(
                                child: DropdownButton(
                                  value: loginController.dropdownValue,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  isDense: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  hint: Text(
                                    "Select Profession Type",
                                    style: TextStyle(color: AppColor.purple),
                                  ),
                                  items:
                                      loginController.items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: NormalText(items,
                                          fontSize: 15, color: AppColor.purple),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      loginController.dropdownValue = newValue!;
                                      if (loginController.dropdownValue ==
                                          'Other') {
                                        setState(() {
                                          loginController.isOther = true;
                                        });
                                      } else {
                                        setState(() {
                                          loginController.isOther = false;
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Visibility(
                              visible: loginController.isOther,
                              child: TextFormField(
                                toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  cut: true,
                                  paste: true,
                                  selectAll: true,
                                ),
                                controller: loginController.otherController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 15),
                                  fillColor: AppColor.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: AppColor.lightPurple,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: AppColor.lightPurple,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColor.secondary,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                  isDense: true,
                                  hintText: 'Type here',
                                  errorMaxLines: 2,
                                  errorStyle:
                                      const TextStyle(height: 0, fontSize: 10),
                                  hintStyle: TextStyle(
                                    color: AppColor.purple,
                                    fontSize: 15,
                                    fontFamily: 'Rubik',
                                  ),
                                ),
                              ),
                            ),

                            // textField(
                            //     controller: loginController.passwordController,
                            //     validator: (val){
                            //       if(val == null || val.isEmpty){
                            //         return 'Please enter your password';
                            //       }else if(val.length < 6){
                            //         return 'Must be more than 6 character';
                            //       }return null;
                            //     },
                            //     textInputAction: TextInputAction.done,
                            //     maxLines: 1,
                            //     suffixIcon: GestureDetector(
                            //       onTap: () {
                            //         loginController.passwordHide(context);
                            //         setState(() {});
                            //       },
                            //       child: Transform.scale(
                            //           scale: 0.6,
                            //           child: loginController.password
                            //               ? SvgPicture.asset(Images.eyesOpen)
                            //               : SvgPicture.asset(Images.eyesClose)),
                            //     ),
                            //     hint: 'Password',
                            //     obscureText: loginController.password),
                            // Align(
                            //     alignment: Alignment.centerRight,
                            //     child: NormalText(txtForgetPass, fontSize: 14, color: AppColor.green)),
                            // SizedBox(height: 3.h,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                    print(value);
                                  },
                                ),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'I agree with',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.purple,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' terms & conditions',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.primary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Terms_and_Conditions()));
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            loginController.isLoading
                                ? loaderButton()
                                : customButton(
                                    title: 'Login',
                                    onTap: () {
                                      login();
                                      // Get.to(StepperScreen());
                                    }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (loginController.formKey.currentState!.validate()) {
      if (_isChecked) {
        setState(() {
          loginController.isLoading = true;
        });
        if (loginController.dropdownValue != null) {
          signUpAPI().then((res) {
            print("Login Res : $res");
            if (res['status']) {
              setState(() {
                save("first_name", loginController.firstNameController.text);
                save("last_name", "");
                save("email", loginController.emailController.text);
                save("phone", loginController.phoneNumberController.text);
                save("user_type", loginController.dropdownValue.toString());
                save("other_type", loginController.otherController.text);
                loginController.isLoading = false;
              });
              showMsg(context, msg: res['message'], color: Colors.green);
              Get.to(SendOTPScreen(sentotp: res['data'].toString()));
            } else {
              showMsg(context, msg: res['message'], color: Colors.red);
            }
          });
        } else {
          showMsg(context,
              msg: 'Selected your Profession Type', color: Colors.red);
        }
      } else {
        showMsg(context,
            msg: 'Please agree to the terms and conditions', color: Colors.red);
      }
    }
    // Future.delayed(
    //   const Duration(seconds: 2),
    //   () {
    //     setState(() {
    //       loginController.isLoading = false;
    //     });
    //   },
    // );
  }

  Future signUpAPI() async {
    String url = "${baseUrl}app-register";
    var response = await http.post(
        headers: {"Content-Type": "application/json"},
        Uri.parse(url),
        body: jsonEncode({
          "full_name": loginController.firstNameController.text,
          "phone": loginController.phoneNumberController.text,
          "email": loginController.emailController.text
        }));
    var model = jsonDecode(response.body);
    return model;
  }
}
