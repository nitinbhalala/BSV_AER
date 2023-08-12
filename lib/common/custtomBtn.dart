import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'colors.dart';

Widget customButton({
  VoidCallback? onTap,
  required String title,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2.h),
      child: Container(
        height: 7.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.primary,
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: AppColor.white),
        )),
      ),
    ),
  );
}

Widget customButtonNew({
  VoidCallback? onTap,
  required String title,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 7.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.primary,
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: AppColor.white),
        )),
      ),
    ),
  );
}

Widget loaderButton({
  VoidCallback? onTap,
  // required String title,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3.h),
      child: Container(
        height: 7.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.primary,
        ),
        child: Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColor.white,
        )),
      ),
    ),
  );
}
