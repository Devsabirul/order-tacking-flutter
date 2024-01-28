import 'package:dbordertracking/controllers/outlet_conroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({super.key});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  OutletController outletController = Get.put(OutletController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var outletId = Get.arguments.toString();
    print(outletId);
    outletController.searchOutlet(outletId);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
