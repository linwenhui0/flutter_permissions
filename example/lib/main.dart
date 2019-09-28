import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_permissions/flutter_permissions.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StringBuffer textBuffer = new StringBuffer();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Column(
          children: <Widget>[
            new MaterialButton(
              onPressed: () async {
                await FlutterPermissions.openSettings();
              },
              child: new Text("打开设置"),
            ),
            new MaterialButton(
              onPressed: () async {
                PermissionStatus result =
                    await FlutterPermissions.requestPermission(
                        Permission.ReadContacts);
                setState(() {
                  textBuffer.write("申请读取通讯录权限结果$result\n");
                });
              },
              child: new Text("申请读取通讯录权限"),
            ),
            new MaterialButton(
              onPressed: () async {
                PermissionStatus result =
                    await FlutterPermissions.requestPermission(
                        Permission.WriteContacts);
                setState(() {
                  textBuffer.write("申请写入通讯录权限结果$result\n");
                });
              },
              child: new Text("申请写入通讯录权限"),
            ),
            new MaterialButton(
              onPressed: () async {
                PermissionStatus result =
                    await FlutterPermissions.requestPermission(
                        Permission.Camera);
                setState(() {
                  textBuffer.write("申请相机权限结果$result\n");
                });
              },
              child: new Text("申请相机权限"),
            ),
            new MaterialButton(
              onPressed: () async {
                PermissionStatus result =
                    await FlutterPermissions.requestPermission(
                        Permission.AccessFineLocation);
                setState(() {
                  textBuffer.write("申请定位权限结果$result\n");
                });
              },
              child: new Text("申请定位权限"),
            ),
            new MaterialButton(
              onPressed: () async {
                PermissionStatus result =
                    await FlutterPermissions.requestPermission(
                        Permission.RecordAudio);
                setState(() {
                  textBuffer.write("申请录音权限结果$result\n");
                });
              },
              child: new Text("申请录音权限"),
            ),
            new MaterialButton(
              onPressed: () async {
                PermissionStatus result =
                    await FlutterPermissions.requestPermissions([
                  Permission.WriteExternalStorage,
                  Permission.Camera,
                  Permission.RecordAudio
                ]);
                setState(() {
                  textBuffer.write("申请sd卡/相机/录音权限结果$result\n");
                });
              },
              child: new Text("申请sd卡/相机/录音权限"),
            ),
            new Text(textBuffer.toString())
          ],
        ),
      ),
    );
  }
}
