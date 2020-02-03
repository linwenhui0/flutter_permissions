import 'dart:async';

import 'package:flutter_permissions/flutter_permissions_platform_interface.dart';

class FlutterPermissions {
  FlutterPermissions._();

  static FlutterPermissionsPlatform get _store =>
      FlutterPermissionsPlatform.instance;

  static Future<PermissionStatus> requestPermission(
          Permission permission) async =>
      _store.requestPermission(permission);

  static Future<PermissionStatus> requestPermissions(
          List<Permission> permissions) async =>
      _store.requestPermissions(permissions);

  /// Open app settings on Android and ios
  static Future<bool> openSettings() async => _store.openSettings();
}
