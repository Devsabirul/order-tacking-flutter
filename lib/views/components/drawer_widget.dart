import 'package:dbordertracking/constants.dart';
import 'package:dbordertracking/views/screens/home_screen.dart';
import 'package:dbordertracking/views/screens/order_summary.dart';
import 'package:dbordertracking/views/screens/outlist_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 260,
                width: Get.width,
                child: Image.asset(
                  "assets/images/sm.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey[200],
                        child: InkWell(
                          onTap: () {
                            Get.off(const HomeScreen(),
                                transition: Transition.fade);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.home,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Dashboard",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        // color: Colors.grey[100],
                        child: InkWell(
                          onTap: () {
                            Get.off(const OutlistListScreen(),
                                transition: Transition.noTransition);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.add_chart,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Add Order",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        // color: Colors.grey[100],
                        child: InkWell(
                          onTap: () {
                            Get.off(const OrderSummaryScreen(),
                                transition: Transition.noTransition);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.assignment_add,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Order Summary",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        // color: Colors.grey[100],
                        child: InkWell(
                          onTap: () {
                            // Get.off(const OutlistListScreen(),
                            //     transition: Transition.noTransition);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.credit_score_outlined,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Create Memu",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
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
