import 'package:dbordertracking/constants.dart';
import 'package:dbordertracking/controllers/settings_controller.dart';
import 'package:dbordertracking/models/distributor_info.dart';
import 'package:dbordertracking/views/components/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConfigerCompanyDetails extends StatefulWidget {
  const ConfigerCompanyDetails({super.key});

  @override
  State<ConfigerCompanyDetails> createState() => _ConfigerCompanyDetailsState();
}

class _ConfigerCompanyDetailsState extends State<ConfigerCompanyDetails> {
  DistributorInfoControler distributorInfoControler =
      Get.put(DistributorInfoControler());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "ব্যাবসায় নিবন্ধন ফরম",
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Form(
                  key: distributorInfoControler.form_key,
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                        controller:
                            distributorInfoControler.distributorNameController,
                        hinttext: 'আপনার ডিস্ট্রিবিউটর নাম লিখুন',
                        validateMsg: 'পৃরণ হয়া বাকি আছে',
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      TextFormFieldWidget(
                        controller: distributorInfoControler
                            .distributorAddressController,
                        hinttext: 'আপনার ডিস্ট্রিবিউটর ঠিকানা লিখুন',
                        validateMsg: 'পৃরণ হয়া বাকি আছে',
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      TextFormFieldWidget(
                        controller:
                            distributorInfoControler.ownerNameController,
                        hinttext: 'আপনার মালিকের নাম লিখুন',
                        validateMsg: 'পৃরণ হয়া বাকি আছে',
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      TextFormFieldWidget(
                        controller:
                            distributorInfoControler.ownerPhoneController,
                        hinttext: 'আপনার মালিকের নাম্বার লিখুন',
                        validateMsg: 'পৃরণ হয়া বাকি আছে',
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      TextFormFieldWidget(
                        controller:
                            distributorInfoControler.poribesokController,
                        hinttext: 'পরিবেশক নাম লিখুন',
                        validateMsg: 'পৃরণ হয়া বাকি আছে',
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (distributorInfoControler.form_key.currentState!
                              .validate()) {
                            distributorInfoControler.insertInfo(DistributorInfo(
                              id: 1,
                              distributorName: distributorInfoControler
                                  .distributorNameController.text
                                  .toString(),
                              distributorAddress: distributorInfoControler
                                  .distributorAddressController.text
                                  .toString(),
                              name: distributorInfoControler
                                  .ownerNameController.text
                                  .toString(),
                              number: distributorInfoControler
                                  .ownerPhoneController.text
                                  .toString(),
                              companyName: distributorInfoControler
                                  .poribesokController.text
                                  .toString(),
                            ));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          fixedSize: Size(Get.width, 53),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Obx(
                          () => distributorInfoControler.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "নিবন্ধন করুন",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
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
