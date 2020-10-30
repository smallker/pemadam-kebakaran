import 'package:air_quality/services/fcm_service.dart';
import 'package:air_quality/services/firebase_db.dart';

class Init {
  static init() {
    FirebaseDb.realtimeData();
    FirebaseDb.history();
    FcmService.init();
  }
}
