import 'dart:async';

import 'package:flutter_permissions/flutter_permissions_platform_interface.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class FlutterPermissionsWebPlugin extends FlutterPermissionsPlatform {
  static void registerWith(Registrar registrar) {
    FlutterPermissionsPlatform.instance = FlutterPermissionsWebPlugin();
  }

  @override
  Future<bool> openSettings() async => false;

  @override
  Future<PermissionStatus> requestPermission(Permission permission) async =>
      PermissionStatus.authorized;

  @override
  Future<PermissionStatus> requestPermissions(
          List<Permission> permissions) async =>
      PermissionStatus.authorized;
}
