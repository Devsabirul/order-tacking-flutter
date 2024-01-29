import 'package:dbordertracking/controllers/memu/memu_controllers.dart';
import 'package:dbordertracking/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderSummaryController extends GetxController {
  MemuController controller = MemuController();

  RxString date = "".obs;
  RxList orders = [].obs;
  RxDouble todaysales = 0.0.obs;

  datePicker(context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (datePicker != null) {
      final formattedDate = DateFormat('dd-MM-yyyy').format(datePicker);
      getOrder(formattedDate);
      date.value = formattedDate;
    }
  }

  getOrder(date) {
    controller.getOrdersByDate(date).then((value) {
      orders.value = value;
    });
    controller.totalSalesForDate(date).then((value) {
      todaysales.value = value;
    });
  }
}
