package com.example.fitlocker

import android.app.AppOpsManager
import android.content.Intent
import android.os.Bundle
import com.example.fitlocker.service.LockingService

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.pm.PackageManager
import android.util.Log
import android.provider.Settings.ACTION_USAGE_ACCESS_SETTINGS
import android.app.AppOpsManager.OPSTR_GET_USAGE_STATS
import android.content.Context
import android.content.Context.APP_OPS_SERVICE
import androidx.core.content.ContextCompat.getSystemService
import android.os.Build.VERSION_CODES.KITKAT
import android.os.Build.VERSION.SDK_INT
import android.provider.Settings
import android.provider.Settings.ACTION_USAGE_ACCESS_SETTINGS








class MainActivity: FlutterActivity() {
    val PLATFORM_CHANNEL = "feelfreelinux.github.io/fitlocker"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        showDialog()
        startService(Intent(this, LockingService::class.java))
        MethodChannel(flutterView, PLATFORM_CHANNEL).setMethodCallHandler {
            methodCall, result ->
            if (methodCall.method == "queryPackages") {
                val pm = this.packageManager
                val intent = Intent(Intent.ACTION_MAIN, null)
                intent.addCategory(Intent.CATEGORY_LAUNCHER)
                val data= pm.queryIntentActivities(intent,
                        PackageManager.PERMISSION_GRANTED).map {
                    it.activityInfo.applicationInfo.loadLabel(pm).toString() + ';' + it.activityInfo.applicationInfo.packageName
                }
                Log.v("FitLocker", data[0])
                result.success(data)
            }
        }
    }

    private fun showDialog() {
        if (!isStatAccessPermissionSet(this@MainActivity) && isNoOption(this@MainActivity)) {
            val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
            startActivity(intent)
        }
    }

    fun isStatAccessPermissionSet(context: Context): Boolean {
        try {
            val packageManager = context.getPackageManager()
            val info = packageManager.getApplicationInfo(context.getPackageName(), 0)
            val appOpsManager = context.getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
            appOpsManager.checkOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, info.uid, info.packageName)
            return appOpsManager.checkOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, info.uid, info.packageName) == AppOpsManager.MODE_ALLOWED
        } catch (e: Exception) {
            e.printStackTrace()
            return false
        }

    }

    fun isNoOption(context: Context): Boolean {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            val packageManager = context.packageManager
            val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
            val list = packageManager.queryIntentActivities(intent, PackageManager.MATCH_DEFAULT_ONLY)
            return list.size > 0
        }
        return false
    }
}