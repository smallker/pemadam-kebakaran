import 'package:get/get.dart';

class PageCtl extends GetxController {
  int page = 0;
  updatePage(int page) {
    this.page = page;
    update();
  }
}
