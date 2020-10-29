import 'package:air_quality/model/history_model.dart';
import 'package:get/get.dart';

class HistoryCtl extends GetxController {
  List<HistoryModel> history;

  updateHistory(List<HistoryModel> history) {
    this.history = history;
    update();
  }
}
