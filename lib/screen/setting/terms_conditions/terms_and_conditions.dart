// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:bsv_app/common/colors.dart';
import 'package:bsv_app/common/images.dart';
import 'package:bsv_app/common/normal_text.dart';
import 'package:bsv_app/screen/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class Terms_and_Conditions extends StatefulWidget {
  const Terms_and_Conditions({super.key});

  @override
  State<Terms_and_Conditions> createState() => _Terms_and_ConditionsState();
}

class _Terms_and_ConditionsState extends State<Terms_and_Conditions> {
  String tnc = "";
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTnCData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(Images.bg),
          fit: BoxFit.fill,
        )),
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
                      Get.back();
                    },
                  ),
                  NormalText(
                    "Terms & Conditions",
                    fontSize: 18,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                  ),
                  Container(width: 25),
                ],
              ),
              (isLoading)
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primary,
                        ),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Html(data: tnc),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          ),
        )),
      ),
    );
  }

  getTnCData() async {
    String url = "${baseUrl}cms";
    var response = await http.get(Uri.parse(url));
    var model = jsonDecode(response.body);
    if (model['status']) {
      setState(() {
        tnc = model['data']['tnc'];
        isLoading = false;
      });
    }
  }
}
