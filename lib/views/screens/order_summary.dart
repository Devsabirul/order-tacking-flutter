import 'package:dbordertracking/constants.dart';
import 'package:dbordertracking/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: InkWell(
          onTap: () {
            Get.off(const HomeScreen(), transition: Transition.noTransition);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: const Text(
          "Order Summary",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ChartWidget(),
              Text("EJ"),
            ],
          ),
        ),
      ),
    );
  }
}
