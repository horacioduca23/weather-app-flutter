import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_permission_controller.g.dart';

@riverpod
class LocationPermissionController extends _$LocationPermissionController {
  @override
  bool build() {
    return false;
  }

  void setLocationPermission(bool permission) => state = permission;
}
