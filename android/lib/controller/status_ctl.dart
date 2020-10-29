import 'package:air_quality/model/status_model.dart';
import 'package:get/get.dart';

class StatusCtl extends GetxController {
  StatusModel status;

  updateRealtime(StatusModel status) {
    this.status = status;
    update();
  }
}
