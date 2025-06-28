import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_task/commons/widgets/KFilledBtn.dart';
import 'package:get_task/commons/widgets/KText.dart';
import 'package:get_task/features/counter/presentation/controller/counter_controller.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Counter Controller
    final CounterController counterController = Get.find();

    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 30,
            children: [
              // Counter
              Obx(
                () => KText(
                  text: "counter ${counterController.count}",
                  textAlign: TextAlign.center,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),

              // Increment Btn
              KFilledBtn(
                label: "Increment",
                icon: Icons.add,
                onPressed: () {
                  counterController.increment();
                },
              ),

              // Decrement Btn
              KFilledBtn(
                label: "Decrement",
                icon: Icons.minimize,
                onPressed: () {
                  counterController.decrement();
                },
              ),

              // Reset Btn
              KFilledBtn(
                label: "Reset",
                icon: Icons.minimize,
                onPressed: () {
                  counterController.reset();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
