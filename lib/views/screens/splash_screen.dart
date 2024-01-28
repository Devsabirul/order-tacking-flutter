import 'dart:async';

import 'package:dbordertracking/constants.dart';
import 'package:dbordertracking/controllers/settings_controller.dart';
import 'package:dbordertracking/databasehalper.dart';
import 'package:dbordertracking/views/screens/add_order_memu.dart';
import 'package:dbordertracking/views/screens/configercompany.dart';
import 'package:dbordertracking/views/screens/home_screen.dart';
import 'package:dbordertracking/views/screens/outlist_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplahsScreen extends StatefulWidget {
  const SplahsScreen({super.key});

  @override
  State<SplahsScreen> createState() => _SplahsScreenState();
}

class _SplahsScreenState extends State<SplahsScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  DistributorInfoControler distributorInfoControler =
      Get.put(DistributorInfoControler());

  @override
  void initState() {
    super.initState();
    databaseHelper.initDatabase();
    distributorInfoControler.getDistributorInfo();
    Timer(
      const Duration(seconds: 3),
      () => {
        if (distributorInfoControler.dbinfo.isNotEmpty)
          {
            Get.off(const HomeScreen(), transition: Transition.fadeIn),
          }
        else
          {
            Get.off(const ConfigerCompanyDetails(),
                transition: Transition.fadeIn),
          }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Order Tacking",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
