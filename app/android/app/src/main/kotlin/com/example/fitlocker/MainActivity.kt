package com.example.fitlocker

import android.content.Intent
import android.os.Bundle
import com.example.fitlocker.service.LockingService

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.pm.PackageManager
import android.util.Log


class MainActivity: FlutterActivity() {
    val PLATFORM_CHANNEL = "feelfreelinux.github.io/fitlocker"

  override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)
      GeneratedPluginRegistrant.registerWith(this)
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
}
