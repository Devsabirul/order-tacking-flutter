import 'dart:convert';
import 'package:dbordertracking/constants.dart';
import 'package:dbordertracking/controllers/memu/memu_controllers.dart';
import 'package:dbordertracking/controllers/outlet_conroller.dart';
import 'package:dbordertracking/controllers/settings_controller.dart';
import 'package:dbordertracking/databasehalper.dart';
import 'package:dbordertracking/models/distributor_info.dart';
import 'package:dbordertracking/models/order_model.dart';
import 'package:dbordertracking/views/screens/home_screen.dart';
import 'package:dbordertracking/views/screens/outlist_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class AddOrderMemu extends StatefulWidget {
  const AddOrderMemu({super.key});

  @override
  State<AddOrderMemu> createState() => _AddOrderMemuState();
}

class _AddOrderMemuState extends State<AddOrderMemu> {
  final MemuController _memuController = Get.put(MemuController());
  DistributorInfoControler distributorInfoControler =
      Get.put(DistributorInfoControler());
  OutletController outletController = Get.put(OutletController());

  var outletId;
  RxString outletname = "".obs;
  RxString outletaddress = "".obs;
  bool isLoading = true;

  _showDialogItemsForm(BuildContext context) {
    return showDialog(
        barrierColor: const Color.fromARGB(176, 0, 0, 0),
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
            title: Text(
              "পন্য যোগ করুন",
              style: TextStyle(
                fontSize: 23.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: _memuController.form_key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _memuController.productname,
                      decoration: const InputDecoration(
                          hintText: "পণ্যের নাম লিখুন",
                          contentPadding: EdgeInsets.all(2)),
                    ),
                    TextFormField(
                      controller: _memuController.productprice,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "পণ্যের দাম লিখুন",
                        contentPadding: EdgeInsets.all(2),
                      ),
                      onChanged: (value) {
                        _memuController.calculateTotalAmount();
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _memuController.productquantity,
                      decoration: const InputDecoration(
                        hintText: "পণ্যের পরিমান লিখুন",
                        contentPadding: EdgeInsets.all(2),
                      ),
                      onChanged: (value) {
                        _memuController.calculateTotalAmount();
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintText: "পণ্যের মোট টাকা",
                          contentPadding: EdgeInsets.all(2),
                        ),
                        controller: TextEditingController(
                            text: _memuController.totalAmountController.value),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${_memuController.msg}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _memuController.addItems(context);
                    },
                    child: Text(
                      "যোগ করুন",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _memuController.closeDialogBox(context);
                    },
                    child: Text(
                      "বতিল করুন",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    distributorInfoControler.getDistributorInfo();
    outletId = Get.arguments;
    outletId.toString();
    getOutlet(outletId);
  }

  getOutlet(id) async {
    await outletController.getOutletById(outletId).then((value) {
      outletname.value = outletController.outletInfo?['name'];
      outletaddress.value = outletController.outletInfo?['address'];
    });
  }

  orderGive() async {
    Order order = Order(
      orderId: _memuController.randomOrderId.value,
      date: _memuController.getCurrentDate(),
      outletName: outletname.value,
      outletAddress: outletaddress.value,
      totalAmount: _memuController.calculateTotal(),
      remark: _memuController.remark.text.toString(),
      items: _memuController.productList.map((dynamic item) {
        return OrderItem(
          itemName: item['name'] ?? '',
          price: (item['price'] ?? 0.0).toDouble(),
          quantity: (item['quantity'] ?? 0.0).toDouble(),
          orderId: _memuController.randomOrderId.value,
        );
      }).toList(),
    );

    // Insert the order into the database
    await _memuController.insertOrders(order).then((value) {
      Get.off(const OutlistListScreen());
      Get.snackbar("সম্পূর্ণ বার্তা", "অর্ডারটি সম্পূর্ণ হয়েছে");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Get.off(const OutlistListScreen(),
                transition: Transition.noTransition);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: Text(
          "মেমু এড করুন",
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          Obx(
            () => _memuController.productList.isNotEmpty
                ? InkWell(
                    onTap: () {
                      orderGive();
                    },
                    child: const Icon(Icons.save),
                  )
                : InkWell(
                    onTap: () {
                      _showDialogItemsForm(context);
                    },
                    child: const Icon(Icons.add),
                  ),
          ),
          SizedBox(
            width: 12.w,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 12.0),
                child: Obx(
                  () => Align(
                    child: Column(
                      children: [
                        Text(
                          "${distributorInfoControler.dbinfo[0].distributorName}", // DB Name
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "মোকাম: ${distributorInfoControler.dbinfo[0].distributorAddress}", // Address Name
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: textDarkColor,
                          ),
                        ),
                        Text(
                          "পরিচালনায়: ${distributorInfoControler.dbinfo[0].name} , ${distributorInfoControler.dbinfo[0].number}", // numbeer Name
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: textDarkColor,
                          ),
                        ),
                        Text(
                          "পরিবেশক: ${distributorInfoControler.dbinfo[0].companyName}", // Poribesok Name
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: textDarkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "অর্ডার নং: #${_memuController.generateOrderId()} ", // অর্ডার নং
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: textDarkColor,
                      ),
                    ),
                    Text(
                      "অর্ডার তাং: ${_memuController.getCurrentDate()}", // অর্ডার তারিখ
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: textDarkColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Wrap(
                  children: [
                    Obx(
                      () => Text(
                        "নাম: ${outletname}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          color: textDarkColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Wrap(
                  children: [
                    Obx(
                      () => Text(
                        "ঠিকানা: ${outletaddress}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          color: textDarkColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  child: Obx(
                    () => DataTable(
                      border: TableBorder.all(color: Colors.grey),
                      headingRowColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          return primaryColor;
                        },
                      ),
                      headingTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      headingRowHeight: 50,
                      columnSpacing: 30.sp,
                      columns: [
                        const DataColumn(
                          label: Text("পণ্যের নাম"),
                        ),
                        DataColumn(
                          label: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "দর",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Text("পরিমান"),
                        ),
                        const DataColumn(
                          label: Text("মোট"),
                        ),
                      ],
                      rows: _memuController.productList.map<DataRow>((product) {
                        int index =
                            _memuController.productList.indexOf(product);
                        return DataRow(
                          cells: [
                            DataCell(Text(product['name'])),
                            DataCell(Text(product['price'].toString())),
                            DataCell(Text(product['quantity'].toString())),
                            DataCell(
                              Text(product['totalAmount'].toString()),
                            ),
                          ],
                          onLongPress: () {
                            _showDeleteConfirmationDialog(context, index);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                alignment: Alignment.centerRight,
                width: Get.width,
                height: 50,
                color: primaryColor,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "সর্বমোট :",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Obx(
                        () => Text(
                          '${_memuController.calculateTotal()} টাকা',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "নোট লিখুন",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: textDarkColor,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  controller: _memuController.remark,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 173, 173, 173),
                    enabledBorder: InputBorder.none,
                    focusColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          _showDialogItemsForm(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("মুছে না ফেলার অনুরোধ!"),
          content: const Text("আপনি কি পণ্যটি মুছে ফেলতে চান মেমু থেকে?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("না"),
            ),
            TextButton(
              onPressed: () {
                _memuController.productList.removeAt(index);
                _memuController
                    .update(); // Notify GetX that the list has changed
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("হ্যাঁ "),
            ),
          ],
        );
      },
    );
  }
}
