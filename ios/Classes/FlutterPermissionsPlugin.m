#import "FlutterPermissionsPlugin.h"
#import "PermissionTool.h"

@implementation FlutterPermissionsPlugin



+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_permissions"
            binaryMessenger:[registrar messenger]];
  FlutterPermissionsPlugin* instance = [[FlutterPermissionsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"openSettings" isEqualToString:call.method]) {
      [PermissionTool openSettingPermission];
      result(@"openSettings");
  } else if([@"requestPermission" isEqualToString:call.method]){
      NSDictionary* dic = call.arguments;
      NSString* permission = dic[@"permission"];
      [self requestPermission:permission withResult:result];
  } else if([@"requestPermissions" isEqualToString:call.method]) {
      result([[NSNumber alloc] initWithInteger:3]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

-(void)requestPermission:(NSString*)permission withResult:(FlutterResult) result{
    if([@"CAMERA" isEqualToString:permission]) {
        [self requestCameraPermission:result];
    } else if([@"READ_CONTACTS" isEqualToString:permission] || [@"WRITE_CONTACTS" isEqualToString:permission]) {
        [self requestContactPermission:result];
    } else if([@"ACCESS_FINE_LOCATION" isEqualToString:permission] || [@"ACCESS_COARSE_LOCATION" isEqualToString:permission] || [@"WHEN_IN_USE_LOCATION" isEqualToString:permission]) {
        [self requestLocationPermission:result];
    } else if ([@"RECORD_AUDIO" isEqualToString:permission]) {
        [self recordAudioPermission:result];
    } else {
        result([[NSNumber alloc] initWithInteger:3]);
    }
}

#pragma mark 申请录音权限
-(void)recordAudioPermission:(FlutterResult) result {
    [PermissionTool getMicrophonePermission:^(NSInteger authStatus) {
        result([[NSNumber alloc] initWithInteger:authStatus]);
    }];
}

#pragma mark 申请相机权限
-(void)requestCameraPermission:(FlutterResult) result {
    [PermissionTool getCamerasPermission:^(NSInteger authStatus) {
        result([[NSNumber alloc] initWithInteger:authStatus]);
    }];
}

#pragma mark 申请通讯录权限
-(void)requestContactPermission:(FlutterResult) result {
    [PermissionTool getAddressBookPermission:^(NSInteger authStatus) {
        result([[NSNumber alloc] initWithInteger:authStatus]);
    }];
}

#pragma mark 申请定位权限
-(void) requestLocationPermission:(FlutterResult)result {
    [PermissionTool getLocationPermission:false result:^(NSInteger authStatus) {
        result([[NSNumber alloc] initWithInteger:authStatus]);
    }];
}

#pragma mark 申请相册权限
-(void) requestPhotoLibraryPermission:(FlutterResult)result {
    [PermissionTool getPhotosPermission:^(NSInteger authStatus) {
        result([[NSNumber alloc] initWithInteger:authStatus]);
    }];
}

@end
