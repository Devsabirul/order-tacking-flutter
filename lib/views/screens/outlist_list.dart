import 'package:dbordertracking/constants.dart';
import 'package:dbordertracking/controllers/outlet_conroller.dart';
import 'package:dbordertracking/models/outlet_model.dart';
import 'package:dbordertracking/views/screens/add_order_memu.dart';
import 'package:dbordertracking/views/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OutlistListScreen extends StatefulWidget {
  const OutlistListScreen({super.key});

  @override
  State<OutlistListScreen> createState() => _OutlistListScreenState();
}

class _OutlistListScreenState extends State<OutlistListScreen> {
  OutletController outletController = Get.put(OutletController());

  @override
  void initState() {
    super.initState();
    outletController.getOutlet();
  }

  _showDialogItemsForm(BuildContext context) {
    return showDialog(
        barrierColor: const Color.fromARGB(176, 0, 0, 0),
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
            title: Text(
              "দোকান যোগ করুন",
              style: TextStyle(
                fontSize: 23.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            content: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    Obx(
                      () => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${outletController.msg}",
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
                    TextFormField(
                      controller: outletController.nameController,
                      decoration: const InputDecoration(
                          hintText: "দোকানের নাম লিখুন",
                          contentPadding: EdgeInsets.all(2)),
                    ),
                    TextFormField(
                      controller: outletController.addressController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: "দোকানের ঠিকানা লিখুন",
                        contentPadding: EdgeInsets.all(2),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: outletController.personNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: "মালিকের নাম লিখুন",
                        contentPadding: EdgeInsets.all(2),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: outletController.numberController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: "মালিকের নাম্বার লিখুন",
                        contentPadding: EdgeInsets.all(2),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: outletController.outletTypeController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: "কি ধরনের দোকান?",
                        contentPadding: EdgeInsets.all(2),
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
                      outletController
                          .insertOutlet(
                              OutletListModel(
                                name: outletController.nameController.text
                                    .toString(),
                                address: outletController.addressController.text
                                    .toString(),
                                personName: outletController
                                    .personNameController.text
                                    .toString(),
                                number: outletController.numberController.text
                                    .toString(),
                                outletType: outletController
                                    .outletTypeController.text
                                    .toString(),
                              ),
                              context)
                          .then(
                        (value) {
                          outletController.getCall();
                        },
                      );
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
                      outletController.closeDialogBox(context);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Get.off(const HomeScreen(), transition: Transition.noTransition);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: Text(
          "দোকানের লিষ্ট",
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              _showDialogItemsForm(context);
            },
            child: const Icon(Icons.add),
          ),
          SizedBox(
            width: 12.w,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 18.h,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "দোকান খুঁজুন",
                  labelText: "দোকান খুঁজুন",
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.only(left: 20, top: 15, bottom: 15),
                ),
                onChanged: (value) {
                  outletController.searchOutlet(value);
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                flex: 1,
                child: Obx(
                  () => outletController.outletlist.isNotEmpty
                      ? ListView.builder(
                          itemCount: outletController.outletlist.length.toInt(),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Get.to(const AddOrderMemu(),
                                    transition: Transition.fadeIn,
                                    arguments:
                                        outletController.outletlist[index].id);
                              },
                              onLongPress: () {
                                _showDeleteConfirmationDialog(
                                  context,
                                  outletController.outletlist[index].id,
                                  outletController.outletlist[index].name,
                                );
                              },
                              child: Card(
                                elevation: 1,
                                margin: const EdgeInsets.only(bottom: 13),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                    left: 8,
                                    right: 15,
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        outletController.outletlist[index].name,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          color: textDarkColor,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      Text(
                                        outletController
                                            .outletlist[index].address,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          color: textDarkColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, int index, String outletName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("মুছে না ফেলার অনুরোধ!"),
          content: Text("আপনি কি $outletName মুছে ফেলতে চান?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("না"),
            ),
            TextButton(
              onPressed: () {
                outletController.deleteOutlet(index);
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
