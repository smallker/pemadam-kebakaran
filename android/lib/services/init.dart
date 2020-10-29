import 'package:air_quality/services/firebase_db.dart';

class Init {
  static init() {
    FirebaseDb.realtimeData();
    FirebaseDb.history();
  }
}
