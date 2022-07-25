import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';

class GeolocatorController extends GetxController {
  bool isLoadingFinish = false;
  bool isRequiredPermission = false;
  late Position currentPosition;

  Future<Position?> getLocation() async {
    var permission = await Geolocator.checkPermission();

    // ignore: unnecessary_null_comparison
    if (permission == null) {
      return null;
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .catchError((e) {
      // ignore: avoid_print
      print("Error $e");
    });
  }

  void permissionOK() {
    getLocation().then((value) {
      isLoadingFinish = true;
      currentPosition = value!;

      // ignore: unnecessary_null_comparison
      if (currentPosition == null) {
        isRequiredPermission = true;
      } else {
        isRequiredPermission = false;
      }
    });
  }
}
