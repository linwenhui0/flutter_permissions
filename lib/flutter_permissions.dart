import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPermissions {
  FlutterPermissions._();

  static const MethodChannel _channel =
      const MethodChannel('flutter_permissions');

  static Future<PermissionStatus> requestPermission(
      Permission permission) async {
    final status = await _channel.invokeMethod(
        "requestPermission", {"permission": getPermissionString(permission)});
    return status is int
        ? intToPermissionStatus(status)
        : status is bool
            ? (status ? PermissionStatus.authorized : PermissionStatus.denied)
            : PermissionStatus.notDetermined;
  }

  static Future<PermissionStatus> requestPermissions(
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

  /// Open app settings on Android and iOs
  static Future<bool> openSettings() async {
    final bool isOpen = await _channel.invokeMethod("openSettings");
    return isOpen;
  }

  static Future<PermissionStatus> getPermissionStatus(
      Permission permission) async {
    final int status = await _channel.invokeMethod(
        "getPermissionStatus", {"permission": getPermissionString(permission)});
    return intToPermissionStatus(status);
  }

  static PermissionStatus intToPermissionStatus(int status) {
    switch (status) {
      case 0:
        return PermissionStatus.notDetermined;
      case 1:
        return PermissionStatus.restricted;
      case 2:
        return PermissionStatus.denied;
      case 3:
        return PermissionStatus.authorized;
      case 4:
        return PermissionStatus.deniedNeverAsk;
      default:
        return PermissionStatus.notDetermined;
    }
  }
}

/// Enum of all available [Permission]
enum Permission {
  // Android
  // wifi
  AccessWifiState,
  // 网络
  AccessNetworkState,
  // 日历
  ReadCalendar,
  WriteCalendar,
  // 相机
  Camera,
  // 联系人
  ReadContacts,
  WriteContacts,
  GetAccounts,
  // 位置/定位
  AccessFineLocation,
  AccessCoarseLocation,
  // 麦克风
  RecordAudio,
  // 手机
  ReadPhoneState,
  CallPhone,
  ReadCallLog,
  WriteCallLog,
  AddVoiceMail,
  UseSip,
  ProcessOutGoingCalls,
  // 传感器
  BodySensors,
  // 短信
  SendSMS,
  ReceiveSMS,
  ReadSMS,
  ReceiveWapPush,
  ReceiveMMS,
  // 存储卡
  WriteExternalStorage,
  ReadExternalStorage,
  // 不确定
  PhotoLibrary,
  WhenInUseLocation,
  AlwaysLocation,
  Vibrate,
}

/// Permissions status enum (iOs: notDetermined, restricted, denied, authorized, deniedNeverAsk)
/// (Android: denied, authorized, deniedNeverAsk)
enum PermissionStatus {
  notDetermined,
  restricted,
  denied,
  authorized,
  deniedNeverAsk /* android */
}

String getPermissionString(Permission permission) {
  String res;
  switch (permission) {
    case Permission.AccessWifiState:
      res = "ACCESS_WIFI_STATE";
      break;
    case Permission.AccessNetworkState:
      res = "ACCESS_NETWORK_STATE";
      break;
    case Permission.ReadCalendar:
      res = "READ_CALENDAR";
      break;
    case Permission.WriteCalendar:
      res = "WRITE_CALENDAR";
      break;
    case Permission.Camera:
      res = "CAMERA";
      break;
    case Permission.ReadContacts:
      res = "READ_CONTACTS";
      break;
    case Permission.WriteContacts:
      res = "WRITE_CONTACTS";
      break;
    case Permission.GetAccounts:
      res = "GET_ACCOUNTS";
      break;
    case Permission.AccessFineLocation:
      res = "ACCESS_FINE_LOCATION";
      break;
    case Permission.AccessCoarseLocation:
      res = "ACCESS_COARSE_LOCATION";
      break;
    case Permission.RecordAudio:
      res = "RECORD_AUDIO";
      break;
    case Permission.ReadPhoneState:
      res = "READ_PHONE_STATE";
      break;
    case Permission.CallPhone:
      res = "CALL_PHONE";
      break;
    case Permission.ReadCallLog:
      res = "READ_CALL_LOG";
      break;
    case Permission.WriteCallLog:
      res = "WRITE_CALL_LOG";
      break;
    case Permission.AddVoiceMail:
      res = "ADD_VOICEMAIL";
      break;
    case Permission.UseSip:
      res = "USE_SIP";
      break;
    case Permission.ProcessOutGoingCalls:
      res = "PROCESS_OUTGOING_CALLS";
      break;
    case Permission.BodySensors:
      res = "BODY_SENSORS";
      break;
    case Permission.SendSMS:
      res = "SEND_SMS";
      break;
    case Permission.ReceiveSMS:
      res = "RECEIVE_SMS";
      break;
    case Permission.ReadSMS:
      res = "READ_SMS";
      break;
    case Permission.ReceiveWapPush:
      res = "RECEIVE_WAP_PUSH";
      break;
    case Permission.ReceiveMMS:
      res = "RECEIVE_MMS";
      break;
    case Permission.ReadExternalStorage:
      res = "READ_EXTERNAL_STORAGE";
      break;
    case Permission.WriteExternalStorage:
      res = "WRITE_EXTERNAL_STORAGE";
      break;

    case Permission.PhotoLibrary:
      res = "PHOTO_LIBRARY";
      break;
    case Permission.WhenInUseLocation:
      res = "WHEN_IN_USE_LOCATION";
      break;
    case Permission.AlwaysLocation:
      res = "ALWAYS_LOCATION";
      break;
    case Permission.Vibrate:
      res = "VIBRATE";
      break;
  }
  return res;
}
