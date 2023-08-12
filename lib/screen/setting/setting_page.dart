import 'dart:convert';

import 'package:bsv_app/common/colors.dart';
import 'package:bsv_app/common/images.dart';
import 'package:bsv_app/common/normal_text.dart';
import 'package:bsv_app/common/string.dart';
import 'package:bsv_app/screen/auth/login/login_page.dart';
import 'package:bsv_app/screen/constants.dart';
import 'package:bsv_app/screen/setting/editProfile/edit_page.dart';
import 'package:bsv_app/screen/setting/setting_controller.dart';
import 'package:bsv_app/screen/stepper/stepper_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingController settingController = Get.put(SettingController());
  String privacyurl = "";

  @override
  void initState() {
    // settingController.onInit();
    getUrlData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (settingController) {
      return Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.bg), fit: BoxFit.fill)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          Get.to(const StepperScreen());
                        },
                      ),
                      NormalText(
                        txtSettings,
                        fontSize: 18,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                      // SvgPicture.asset(Images.setting),
                      Container(
                        width: 5.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      (settingController.selectimage)
                          ? Container(
                              key: UniqueKey(),
                              height: 160,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(225),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(225),
                                child: Image.file(
                                  settingController.userimage!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(225),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(225),
                                child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj3zizMiOMtIM_Vr1GAAyxCKoQUjP9J19W3JMnbIjyB1xTgMEytEzOyietXhOKwJrplnY&usqp=CAU'),
                              )),
                      GestureDetector(
                        onTap: () {
                          settingController.showActionSheet(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, bottom: 10),
                          child: SvgPicture.asset(Images.add),
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(Images.logo),
                  SizedBox(
                    height: 5.h,
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(const EditScreen());
                    },
                    leading: SvgPicture.asset(Images.editProfile),
                    title: NormalText(txtEditProfile,
                        fontSize: 16, color: AppColor.purple),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  ),
                  Divider(height: 5, thickness: 1, endIndent: 5.w, indent: 5.w),
                  ListTile(
                    onTap: () async {
                      print("uri 1 : $privacyurl");
                      final uri = Uri.parse(privacyurl);
                      print("uri 2: $uri");
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'Could not launch $uri';
                      }
                    },
                    leading: Image.asset(Images.privacyPolicyPng),
                    title: NormalText("Privacy Policy",
                        fontSize: 16, color: AppColor.purple),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  ),
                  // Divider(height: 5,thickness: 1,endIndent: 5.w,indent: 5.w),
                  // ListTile(
                  //   onTap: (){
                  //     Get.to(const ChangePasswordScreen());
                  //   },
                  //   leading: SvgPicture.asset(Images.changePass),
                  //   title: NormalText(txtChangePassword, fontSize: 16, color: AppColor.purple),
                  //   trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 15,),
                  // ),
                  Divider(height: 5, thickness: 1, endIndent: 5.w, indent: 5.w),
                  // ListTile(
                  //   leading: SvgPicture.asset(Images.notification),
                  //   title: NormalText(txtNotifications, fontSize: 16, color: AppColor.purple),
                  //   trailing: CupertinoSwitch(
                  //     activeColor: AppColor.green,
                  //     thumbColor: AppColor.white,
                  //     trackColor: Colors.black12,
                  //     value: settingController.forIos,
                  //     onChanged: (value) => setState(() => settingController.forIos = value),
                  //   ),
                  // ),
                  // Divider(height: 5,thickness: 1,endIndent: 5.w,indent: 5.w),
                  ListTile(
                    onTap: () {
                      setState(() {
                        Get.to(const LoginScreen());
                      });
                    },
                    leading: SvgPicture.asset(Images.logout),
                    title: NormalText(txtLogout,
                        fontSize: 16, color: AppColor.purple),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  ),
                  Divider(height: 5, thickness: 1, endIndent: 5.w, indent: 5.w),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  getUrlData() async {
    String url = "${baseUrl}cms";
    var response = await http.get(Uri.parse(url));
    var model = jsonDecode(response.body);
    if (model['status']) {
      print("privacy_policy_url : ${model['data']['privacy_policy_url']}");
      setState(() {
        privacyurl = model['data']['privacy_policy_url'];
      });
    }
  }
}
