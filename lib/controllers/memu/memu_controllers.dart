import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:dbordertracking/databasehalper.dart';
import 'package:dbordertracking/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class MemuController extends GetxController {
  DatabaseHelper databasehelper = DatabaseHelper();
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productquantity = TextEditingController();
  TextEditingController remark = TextEditingController();

  final form_key = GlobalKey<FormState>();
  RxString msg = "".obs;
  RxString totalAmountController = "0.0".obs;
  RxInt randomOrderId = 0.obs;
  RxList productList = [].obs;
  RxList finalorders = <Order>[].obs;
  RxString outletname = "".obs;
  RxString outletaddress = "".obs;
  RxDouble totalAmount = 0.0.obs;
  RxDouble todaysales = 0.0.obs;

  clearItems() {
    productname.clear();
    productprice.clear();
    productquantity.clear();
  }

  addItems(context) {
    if (productname.text.isNotEmpty &&
        productprice.text.isNotEmpty &&
        productquantity.text.isNotEmpty) {
      // Calculate total amount
      calculateTotalAmount();

      // Add the current product to the list
      productList.add({
        'name': productname.text,
        'price': double.parse(productprice.text),
        'quantity': double.parse(productquantity.text),
        'totalAmount': double.parse(totalAmountController.value),
      });

      // Clear form fields
      clearItems();

      // Reset totalAmountController
      totalAmountController.value = "0.0";
      msg.value = "";
      Navigator.pop(context);
    } else {
      msg.value = "সব গুলো পূরণ করুন";
    }
  }

  closeDialogBox(context) {
    clearItems();
    msg.value = "";
    totalAmountController.value = "0.0";
    Navigator.pop(context);
  }

  // Method to generate a random 5-digit number
  int generateOrderId() {
    Random random = Random();
    var randomId = 10000 + random.nextInt(90000);
    randomOrderId.value = randomId;
    return randomId;
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }

  // Function to calculate total amount
  void calculateTotalAmount() {
    double price = double.tryParse(productprice.text) ?? 0;
    double quantity = double.tryParse(productquantity.text) ?? 0;

    double totalAmount = price * quantity;

    // Update the total amount using reactive variable
    totalAmountController.value = totalAmount.toStringAsFixed(2);
  }

  // Method to calculate the total of all products
  double calculateTotal() {
    double total = 0;

    for (Map<String, dynamic> product in productList) {
      total += product['totalAmount'] as double;
    }

    return total;
  }

  Future<int> insertOrders(Order order) async {
    Database db = await databasehelper.initDatabase();
    int orderId = await db.insert('orders', order.toMap());

    for (OrderItem item in order.items) {
      await db.insert('order_items', item.toMap());
    }
    productList.clear();
    remark.clear();
    TotalSales_();
    totalSalesForDate(getCurrentDate());
    return orderId;
  }

  Future<List<Order>> getOrders() async {
    try {
      Database db = await databasehelper.initDatabase();
      List<Map<String, dynamic>> result = await db.query('orders');
      List<Order> orders = [];
      for (Map<String, dynamic> map in result) {
        List<Map<String, dynamic>> items = await db
            .query('order_items', where: 'orderId = ?', whereArgs: [map['id']]);
        List<OrderItem> orderItems =
            items.map((item) => OrderItem.fromMap(item)).toList();
        Order order = Order.fromMap(map, orderItems);
        orders.add(order);
      }
      return orders;
    } catch (e) {
      return [];
    }
  }

  Future getOrderById(int orderId) async {
    Database db = await databasehelper.initDatabase();
    List<Map<String, dynamic>> result = await db.query(
      'orders',
      where: 'orderId = ?',
      whereArgs: [orderId],
    );

    if (result.isNotEmpty) {
      Map<String, dynamic> map = result.first;
      List<Map<String, dynamic>> items = await db.query(
        'order_items',
        where: 'orderId = ?',
        whereArgs: [map['orderId']],
      );
      List<OrderItem> orderItems =
          items.map((item) => OrderItem.fromMap(item)).toList();
      Order order = Order.fromMap(map, orderItems);

      return order;
    }
  }

  Future getOrdersByDate(String date) async {
    Database db = await databasehelper.initDatabase();

    List<Map<String, dynamic>> result = await db.query(
      'orders',
      where: 'date = ?',
      whereArgs: [date],
    );

    List<Order> orders = [];

    for (Map<String, dynamic> map in result) {
      List<Map<String, dynamic>> items = await db.query(
        'order_items',
        where: 'orderId = ?',
        whereArgs: [map['id']],
      );
      List<OrderItem> orderItems =
          items.map((item) => OrderItem.fromMap(item)).toList();
      Order order = Order.fromMap(map, orderItems);
      orders.add(order);
    }
    finalorders.value = orders;
    return orders;
  }

  Future deleteOrder(int orderId) async {
    Database db = await databasehelper.initDatabase();
    var result =
        db.delete('orders', where: 'orderId = ?', whereArgs: [orderId]);
    getOrdersByDate(getCurrentDate());
    TotalSales_();
    totalSalesForDate(getCurrentDate());
    return result;
  }

  Future<double> TotalSales_() async {
    Database db = await databasehelper.initDatabase();

    // Use the rawQuery method with the SUM aggregate function
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT SUM(totalAmount) AS totalAmount FROM orders',
    );

    // Extract the totalAmount from the result
    totalAmount.value = result.first['totalAmount'] ?? 0.0;

    return result.first['totalAmount'];
  }

//  large number to shorten K/M/B
  getShortForm(var number) {
    var f = NumberFormat.compact(locale: "en_US");
    return f.format(number);
  }

  Future<double> totalSalesForDate(String targetDate) async {
    Database db = await databasehelper.initDatabase();

    // Use the rawQuery method with the SUM aggregate function and date filter
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT SUM(totalAmount) AS totalAmount FROM orders WHERE date = ?',
      [targetDate],
    );

    // Extract the totalAmount from the result
    double totalAmount = result.first['totalAmount'] ?? 0.0;

    todaysales.value = totalAmount;
    print(todaysales);
    return totalAmount;
  }
}
