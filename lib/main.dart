import 'package:dbordertracking/views/screens/add_order_memu.dart';
import 'package:dbordertracking/views/screens/home_screen.dart';
import 'package:dbordertracking/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(Get.width, Get.height),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: "/",
            routes: {
              "/": (context) => const SplahsScreen(),
              "/homescreen": (context) => const HomeScreen(),
              "/addmemu": (context) => const AddOrderMemu(),
            },
          );
        });
  }

  static of(BuildContext context) {}
}
