import 'package:bsv_app/screen/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: const Color(0xFF00B7CA).withOpacity(0.1),
    // status bar color
  ));
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'BSV',
          theme: ThemeData(
            fontFamily: GoogleFonts.rubik().fontFamily,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    ),
  );
}


 // flutter build appbundle --release --build-name=1.1.0 --build-number=2 --target-platform=android-arm64
