import 'package:bsv_app/common/colors.dart';
import 'package:bsv_app/common/custtomBtn.dart';
import 'package:bsv_app/common/images.dart';
import 'package:bsv_app/common/normal_text.dart';
import 'package:bsv_app/common/string.dart';
import 'package:bsv_app/common/textField.dart';
import 'package:bsv_app/common/widget.dart';
import 'package:bsv_app/screen/setting/editProfile/edit_controller.dart';
import 'package:bsv_app/screen/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  void initState() {
    editProfileController.getLocalData();
    print(
        "DropDownButtonValue:- ${editProfileController.dropdownValue.toString()}");
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
            key: editProfileController.formKey,
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
                        txtEditProfile,
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
                  // SizedBox(height: 3.h,),
                  // NormalText(txtWelcomeToProfile, fontSize: 26, color: AppColor.primary),
                  SizedBox(
                    height: 3.h,
                  ),
                  textField(
                      controller: editProfileController.firstNameController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your Full name';
                        }
                      },
                      hint: 'Full name',
                      textInputAction: TextInputAction.next),
                  // textField(
                  //     controller: editProfileController.lastNameController,
                  //     validator: (val) {
                  //       if (val == null || val.isEmpty) {
                  //         return 'Please enter your Last name';
                  //       }
                  //     },
                  //     hint: 'Last name',
                  //     textInputAction: TextInputAction.next),
                  textField(
                      controller: editProfileController.emailController,
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
                      controller: editProfileController.phoneController,
                      length: 10,
                      keyboardType: TextInputType.number,
                      hint: 'Mobile number',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your Phone number';
                        } else if (val.length < 10) {
                          return 'Please enter 10 digits';
                        }
                      },
                      textInputAction: TextInputAction.done),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.lightPurple)),
                    child: Center(
                      child: DropdownButton(
                        value: editProfileController.dropdownValue,
                        isExpanded: true,
                        underline: const SizedBox(),
                        isDense: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: Text(
                          "Profession",
                          style: TextStyle(color: AppColor.purple),
                        ),
                        items: editProfileController.items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: NormalText(items,
                                fontSize: 15, color: AppColor.purple),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            editProfileController.dropdownValue = newValue!;
                            if (editProfileController.dropdownValue ==
                                'Other') {
                              setState(() {
                                editProfileController.isOther = true;
                              });
                            } else {
                              setState(() {
                                editProfileController.isOther = false;
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
                      visible: editProfileController.isOther,
                      child: TextFormField(
                        controller: editProfileController.otherController,
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
                          errorStyle: const TextStyle(height: 0, fontSize: 10),
                          hintStyle: TextStyle(
                            color: AppColor.purple,
                            fontSize: 15,
                            fontFamily: 'Rubik',
                          ),
                        ),
                      )),
                  editProfileController.isLoading
                      ? loaderButton()
                      : customButton(
                          title: txtUpdate,
                          onTap: () {
                            editProfile();
                          }),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  editProfile() async {
    if (editProfileController.formKey.currentState!.validate()) {
      setState(() {
        editProfileController.isLoading = true;
      });
      save("first_name", editProfileController.firstNameController.text);
      save("last_name", "");
      save("email", editProfileController.emailController.text);
      save("phone", editProfileController.phoneController.text);
      save("user_type", editProfileController.dropdownValue.toString());
      save("other_type", editProfileController.otherController.text);
      Future.delayed(
        const Duration(seconds: 2),
        () {
          setState(() {
            Get.to(const SettingScreen());
            editProfileController.isLoading = false;
          });
        },
      );
      // editProfileController.editProfile().then((value) {
      //   if (value['status']){
      //     showMsg(context, msg: value['message'], color: Colors.green);
      //   }else{
      //     print("error msg:~ $value");
      //     showMsg(context, msg: value['message'], color: Colors.red);
      //   }
      // });
    }
    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          editProfileController.isLoading = false;
        });
      },
    );
  }
}
