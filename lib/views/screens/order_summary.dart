import 'package:dbordertracking/constants.dart';
import 'package:dbordertracking/controllers/memu/memu_controllers.dart';
import 'package:dbordertracking/controllers/order_summery_controller.dart';
import 'package:dbordertracking/views/screens/home_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  OrderSummaryController controller = Get.put(OrderSummaryController());
  MemuController memucontroller = Get.put(MemuController());

  @override
  void initState() {
    super.initState();

    memucontroller.getOrdersByDate(memucontroller.getCurrentDate());
  }

  @override
  Widget build(BuildContext context) {
    // Sales total amount and number of orders
    double salesTotalAmount = 250000; // 250k
    int numberOfOrders = 10;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Report for :",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: textDarkColor,
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Obx(
                              () => Text(
                                controller.date.value,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textDarkColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            controller.datePicker(context);
                          },
                          child: const Icon(Icons.date_range),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                width: Get.width,
                height: 250,
                child: Card(
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: salesTotalAmount + 50000,
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              fromY: salesTotalAmount,
                              color: Colors.blue,
                              width: 20,
                              toY: 0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      width: Get.width * 0.46,
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
                                    "${memucontroller.getShortForm(controller.todaysales.value)} ৳",
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
                      width: Get.width * 0.46,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "today orders",
                              style: TextStyle(
                                fontSize: 15,
                                color: textLightColor,
                              ),
                            ),
                            Wrap(
                              children: [
                                Obx(
                                  () => Text(
                                    "${controller.orders.length}",
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
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
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
                    Obx(
                      () => Text(
                        "date : ${controller.date}",
                        style: const TextStyle(
                          color: textLightColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(
                  () => controller.orders.isNotEmpty
                      ? Column(
                          children: controller.orders
                              .map(
                                (order) => Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromARGB(255, 216, 216, 216),
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
                                            // memucontroller.deleteOrder(order.orderId);
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
                        )
                      : const Center(
                          child: Text(
                            "orders not found!",
                            style: TextStyle(
                              color: textLightColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
