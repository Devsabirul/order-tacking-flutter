import 'package:dbordertracking/constants.dart';
import 'package:dbordertracking/controllers/memu/memu_controllers.dart';

import 'package:dbordertracking/views/components/drawer_widget.dart';
import 'package:dbordertracking/views/screens/outlist_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MemuController memuController = Get.put(MemuController());

  @override
  void initState() {
    super.initState();
    memuController.getOrdersByDate(memuController.getCurrentDate());
    memuController.TotalSales_();
    memuController.totalSalesForDate(memuController.getCurrentDate());
  }

  List<FlSpot> chartData = [
    FlSpot(0, 1),
    FlSpot(1, 3),
    FlSpot(2, 10),
    FlSpot(3, 7),
    FlSpot(4, 12),
    FlSpot(5, 13),
    FlSpot(6, 17),
    FlSpot(7, 15),
    FlSpot(8, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        backgroundColor: primaryColor,
        elevation: 1,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: const Text(
          "Sales report",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              // print(memuController.orders);
            },
            child: const Icon(
              Icons.notifications_none_sharp,
              color: Colors.white,
              size: 28,
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
        ],
      ),
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(spots: chartData),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                        // gradient: const LinearGradient(
                        //   colors: [
                        //     Color.fromARGB(172, 255, 0, 0),
                        //     Color.fromARGB(170, 255, 0, 0)
                        //   ],
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        // ),
                      ),
                      width: Get.width * 0.47,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "total sales",
                              style: TextStyle(
                                fontSize: 15,
                                color: textLightColor,
                              ),
                            ),
                            Wrap(
                              children: [
                                Obx(
                                  () => Text(
                                    "${memuController.getShortForm(memuController.totalAmount.value)} ৳",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600,
                                      color: textDarkColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: Get.width * 0.47,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "today sales",
                              style: TextStyle(
                                fontSize: 15,
                                color: textLightColor,
                              ),
                            ),
                            Wrap(
                              children: [
                                Obx(
                                  () => Text(
                                    "${memuController.getShortForm(memuController.todaysales.value)} ৳",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600,
                                      color: textDarkColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: Get.width * 0.47,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "this month",
                              style: TextStyle(
                                fontSize: 15,
                                color: textLightColor,
                              ),
                            ),
                            Wrap(
                              children: [
                                Text(
                                  "100tk",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w600,
                                    color: textDarkColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: Get.width * 0.47,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "today order",
                              style: TextStyle(
                                fontSize: 15,
                                color: textLightColor,
                              ),
                            ),
                            Wrap(
                              children: [
                                Obx(
                                  () => Text(
                                    "${memuController.finalorders.length}",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w600,
                                      color: textDarkColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "today orders:",
                      style: TextStyle(
                        color: textLightColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      "date : ${memuController.getCurrentDate()}",
                      style: const TextStyle(
                        color: textLightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(
                  () => Column(
                    children: memuController.finalorders
                        .map(
                          (order) => Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromARGB(255, 216, 216, 216),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.40,
                                    child: Text(
                                      "${order.outletName.length > 23 ? order.outletName.substring(0, 23) + '.' : order.outletName}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.25,
                                    child: Wrap(
                                      children: [
                                        Text(
                                          "${order.outletAddress.length > 12 ? order.outletAddress.substring(0, 12) + '.' : order.outletAddress}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // memuController.deleteOrder(order.orderId);
                                    },
                                    child: const Text(
                                      "view",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: textDarkColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
