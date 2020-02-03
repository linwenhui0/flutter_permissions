package com.hdlang.flutter.flutterpermissions

import android.content.Intent
import android.net.Uri
import android.provider.Settings
import com.hlibrary.util.Logger
import com.hlibrary.util.PermissionGrant
import com.hlibrary.util.PermissionManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar


class FlutterPermissionsPlugin(private val registrar: Registrar) : MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {

    private var permissionManager: PermissionManager? = null
    private var permissionGrant: PermissionGrantImp

    companion object {
        const val OPEN_SETTINGS = "openSettings"
        const val REQUEST_PERMISSION = "requestPermission"
        const val REQUEST_PERMISSIONS = "requestPermissions"
        const val REQUEST_PERMISSION_CODE = 0x1001
        @JvmStatic
        fun registerWith(registrar: Registrar): Unit {
            val channel = MethodChannel(registrar.messenger(), "flutter_permissions")
            val flutterPermissionsPlugin = FlutterPermissionsPlugin(registrar)
            channel.setMethodCallHandler(flutterPermissionsPlugin)
            registrar.addRequestPermissionsResultListener(flutterPermissionsPlugin)
        }
    }

    init {
        permissionGrant = PermissionGrantImp()
        permissionManager = PermissionManager(registrar.activity(), permissionGrant)
    }

    override fun onMethodCall(call: MethodCall, result: Result): Unit {
        when (call.method) {
            OPEN_SETTINGS -> {
                openSettings()
                result.success(true)
            }
            REQUEST_PERMISSION -> {
                permissionGrant.result = result
                val permission: String? = call.argument("permission")
                Logger.instance.defaultTagD("android.permission.$permission")
                permissionManager?.requestPermission(REQUEST_PERMISSION_CODE, "android.permission.$permission")
            }
            REQUEST_PERMISSIONS -> {
                permissionGrant.result = result
                val permissions: List<String>? = call.argument("permissions")
                val mPermissions: Array<String?> = arrayOfNulls(permissions!!.size)
                permissions?.forEachIndexed { index, permission -> mPermissions[index] = "android.permission.$permission" }
                Logger.instance.defaultTagD(mPermissions)
                permissionManager?.requestMultiPermissions(mPermissions as Array<String>)
            }
            else -> result.notImplemented()
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray): Boolean {
        permissionManager?.onRequestPermissionsResult(requestCode, permissions, grantResults)
        return false
    }

    private fun openSettings() {
        val activity = registrar?.activity()
        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                Uri.parse("package:" + activity?.packageName))
        intent.addCategory(Intent.CATEGORY_DEFAULT)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        activity?.startActivity(intent)
    }

    class PermissionGrantImp : PermissionGrant {


        var result: Result? = null

        override fun onPermissionError(e: Exception) {
            this.result?.success(2)
            this.result = null
        }

        override fun onPermissionGranted(permission: String) {
            this.result?.success(3)
            this.result = null
        }

        override fun onPermissionDenied(permissions: ArrayList<String>) {
            this.result?.success(2)
            this.result = null
        }

    }

}
