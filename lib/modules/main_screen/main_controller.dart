import 'package:get/get.dart';

class MainController extends GetxController {
  int currentIndex = 0;

  
  void changeCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    update();
  }
}