import 'package:dbordertracking/databasehalper.dart';
import 'package:dbordertracking/models/distributor_info.dart';
import 'package:dbordertracking/views/screens/add_order_memu.dart';
import 'package:dbordertracking/views/screens/home_screen.dart';
import 'package:dbordertracking/views/screens/outlist_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class DistributorInfoControler extends GetxController {
  DatabaseHelper databasehelper = DatabaseHelper();
  TextEditingController distributorNameController = TextEditingController();
  TextEditingController distributorAddressController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerPhoneController = TextEditingController();
  TextEditingController poribesokController = TextEditingController();

  RxBool isLoading = false.obs;
  final form_key = GlobalKey<FormState>();

  RxList dbinfo = [].obs;

  Future insertInfo(DistributorInfo distributorInfo) async {
    try {
      isLoading.value = true;
      Database db = await databasehelper.initDatabase();
      var data = await db.insert('distributorinfo', distributorInfo.toMap());
      isLoading.value = false;
      Get.off(const HomeScreen(), transition: Transition.fade);
      return data;
    } catch (e) {
      Get.snackbar("Errors", e.toString());
    }
    isLoading.value = false;
  }

  Future getDistributorInfo() async {
    Database db = await databasehelper.initDatabase();
    var info = await db.query('distributorinfo');
    List<DistributorInfo> getinfo = info.isNotEmpty
        ? info.map((e) => DistributorInfo.fromMap(e)).toList()
        : [];
    dbinfo.value = getinfo;
    return getinfo;
  }

  Future<int> updateInfo(DistributorInfo distributorInfo) async {
    Database db = await databasehelper.initDatabase();
    return await db.update('distributorinfo', distributorInfo.toMap(),
        where: 'id = ?', whereArgs: [distributorInfo.id]);
  }

  Future<int> deleteInfo(int id) async {
    Database db = await databasehelper.initDatabase();
    return await db.delete('distributorinfo', where: 'id = ?', whereArgs: [id]);
  }
}
