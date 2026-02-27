import 'package:models/models.dart';

class FirestoreLocationService {
  Stream<Map<String, double>> runnerLocationStream(String runnerId) {
    // Mock stream of location updates
    return Stream.periodic(const Duration(seconds: 5), (i) {
      return {'lat': 30.0444 + (i * 0.001), 'lng': 31.2357 + (i * 0.001)};
    });
  }

  Future<void> updateRunnerLocation(String runnerId, double lat, double lng) async {
    // Mock update to Firestore
    print('Updating runner $runnerId location: $lat, $lng');
  }
}
