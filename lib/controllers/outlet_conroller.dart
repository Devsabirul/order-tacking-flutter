import 'package:dbordertracking/databasehalper.dart';
import 'package:dbordertracking/models/outlet_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class OutletController extends GetxController {
  DatabaseHelper databasehelper = DatabaseHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController outletTypeController = TextEditingController();

  RxBool isLoading = false.obs;
  RxList outletlist = [].obs;
  RxString msg = "".obs;
  Map<String, dynamic>? outletInfo;

  Future insertOutlet(OutletListModel outletList, context) async {
    if (nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        personNameController.text.isNotEmpty &&
        numberController.text.isNotEmpty &&
        outletTypeController.text.isNotEmpty) {
      try {
        isLoading.value = true;
        Database db = await databasehelper.initDatabase();
        var data = await db.insert('outletlist', outletList.toMap());
        msg.value = "";
        clearInputForm();
        isLoading.value = false;
        Navigator.pop(context);
        return data;
      } catch (e) {
        Get.snackbar("Errors", "Something Wrong!");
      }
    } else {
      msg.value = "সব গুলো পূরণ করুন";
    }

    isLoading.value = false;
  }

  Future getOutlet() async {
    Database db = await databasehelper.initDatabase();
    var outlet = await db.query('outletlist');
    List<OutletListModel> getOutletList = outlet.isNotEmpty
        ? outlet.map((e) => OutletListModel.fromMap(e)).toList()
        : [];
    outletlist.value = getOutletList;
    return getOutletList;
  }

  Future<Map<String, dynamic>?> getOutletById(int outletId) async {
    Database db = await databasehelper.initDatabase();
    List<Map<String, dynamic>> outlets = await db.query(
      'outletlist',
      where: 'id = ?', // assuming 'id' is the column name for the outletId
      whereArgs: [outletId],
    );

    outletInfo = outlets.first;
    return outlets.first;
  }

  Future searchOutlet(String keyword) async {
    Database db = await databasehelper.initDatabase();
    var outlet = await db
        .query('outletlist', where: 'name LIKE ?', whereArgs: ['%$keyword%']);
    List<OutletListModel> getOutletList = outlet.isNotEmpty
        ? outlet.map((e) => OutletListModel.fromMap(e)).toList()
        : [];
    outletlist.value = getOutletList;
    return getOutletList;
  }

  clearInputForm() {
    nameController.clear();
    addressController.clear();
    personNameController.clear();
    numberController.clear();
    outletTypeController.clear();
  }

  getCall() {
    getOutlet();
  }

  Future<int> deleteOutlet(int id) async {
    Database db = await databasehelper.initDatabase();
    var result = db.delete('outletlist', where: 'id = ?', whereArgs: [id]);
    getCall();
    return result;
  }

  closeDialogBox(context) {
    clearInputForm();
    msg.value = "";
    Navigator.pop(context);
  }
}
