import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_permissions/flutter_permissions_platform_interface.dart';

const MethodChannel _channel = const MethodChannel('flutter_permissions');

class MethodFlutterPermissions extends FlutterPermissionsPlatform {
  @override
  Future<bool> openSettings() async {
    return await _channel.invokeMethod("openSettings");
  }

  @override
  Future<PermissionStatus> requestPermission(Permission permission) async {
    final status = await _channel.invokeMethod(
        "requestPermission", {"permission": getPermissionString(permission)});
    return status is int
        ? intToPermissionStatus(status)
        : status is bool
            ? (status ? PermissionStatus.authorized : PermissionStatus.denied)
            : PermissionStatus.notDetermined;
  }

  @override
  Future<PermissionStatus> requestPermissions(
      List<Permission> permissions) async {
    if (permissions?.isNotEmpty == true) {
      List<String> mPermissions = [];
      for (Permission permission in permissions) {
        mPermissions.add(getPermissionString(permission));
      }

      final status = await _channel
          .invokeMethod("requestPermissions", {"permissions": mPermissions});
      return status is int
          ? intToPermissionStatus(status)
          : status is bool
              ? (status ? PermissionStatus.authorized : PermissionStatus.denied)
              : PermissionStatus.notDetermined;
    }
    return PermissionStatus.denied;
  }
}
