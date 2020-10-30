import 'package:air_quality/controller/history_ctl.dart';
import 'package:air_quality/controller/status_ctl.dart';
import 'package:air_quality/model/history_model.dart';
import 'package:air_quality/model/status_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirebaseDb {
  static realtimeData() async {
    final ctl = Get.put(StatusCtl());
    Query ref = FirebaseDatabase.instance.reference().child('/realtime');
    ref.onValue.listen(
      (event) {
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic, dynamic> data = snapshot.value;
        // print(data);
        ctl.updateRealtime(StatusModel.fromMap(data));
      },
    );
  }

  static history() async {
    final ctl = Get.put(HistoryCtl());
    Query ref = FirebaseDatabase.instance.reference().child('/history');
    ref.onValue.listen(
      (event) {
        List<HistoryModel> model = [];
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic, dynamic> logs = snapshot.value;
        try {
          logs.forEach(
            (key, value) {
              try {
                model.add(HistoryModel.fromMap(value as Map<dynamic, dynamic>));
              } catch (e) {}
            },
          );
        } catch (e) {}
        ctl.updateHistory(model);
      },
    );
  }
}
