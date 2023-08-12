import 'package:bsv_app/common/colors.dart';
import 'package:bsv_app/common/images.dart';
import 'package:bsv_app/common/normal_text.dart';
import 'package:bsv_app/common/string.dart';
import 'package:bsv_app/screen/successful/successfull_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SuccessFulScreen extends StatefulWidget {
  const SuccessFulScreen({Key? key}) : super(key: key);

  @override
  State<SuccessFulScreen> createState() => _SuccessFulScreenState();
}

class _SuccessFulScreenState extends State<SuccessFulScreen> {
  SuccessFullController successFullController =
      Get.put(SuccessFullController());

  @override
  void initState() {
    successFullController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.bg), fit: BoxFit.fill)),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.succes),
                SizedBox(
                  height: 5.h,
                ),
                NormalText(
                  txtSuccessful,
                  fontSize: 38,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 1.h,
                ),
                NormalText(txtUploadSuccessful,
                    fontSize: 20, color: AppColor.purple),
                SizedBox(
                  height: 3.h,
                ),
                // SizedBox(
                //   width: 80.w,
                //   child: NormalText(
                //     txtDummy3,
                //     textAlign: TextAlign.center,
                //     fontSize: 14,
                //     color: AppColor.purple,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
