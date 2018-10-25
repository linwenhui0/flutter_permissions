package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.hdlang.flutter.flutterpermissions.FlutterPermissionsPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterPermissionsPlugin.registerWith(registry.registrarFor("com.hdlang.flutter.flutterpermissions.FlutterPermissionsPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
