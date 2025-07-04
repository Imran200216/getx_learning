import 'package:get/get.dart';

class CounterController extends GetxController {
  var count = 0.obs;

  // Increment counter
  void increment() {
    count++;
  }

  // Decrement counter
  void decrement() {
    count--;
  }

  void reset() {
    count.value = 0;
  }
}
