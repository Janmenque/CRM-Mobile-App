import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'driver_location_model.dart';

String location = 'location';

class HiveLocationProvider extends ChangeNotifier{
  var box = Hive.box<DriverLocationModel>(location);

  void add(DriverLocationModel location) async {
    await box.add(location);
  }

  DriverLocationModel? getUserLastPosition() {
    return box.isNotEmpty ? box.values.last : null;
  }

  DriverLocationModel? getUserFirstPosition() {
    return box.isNotEmpty ? box.values.first : null;

  }

  Future<void> deleteAllLocation() async {
    await box.clear();
    if (kDebugMode) {
      print("Delete all Local data ${box.values}");
    }
  }

  List<Map<String, dynamic>> toMapList() {
    return box.values.map((e) => e.toJson()).toList();
  }
}
