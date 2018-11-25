package com.example.fitlocker.service

import android.app.ActivityManager
import android.app.Service
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.pm.PackageManager
import androidx.core.app.NotificationCompat

import java.util.ArrayList
import android.app.NotificationManager
import android.app.NotificationChannel
import android.content.*
import android.os.Build
import android.os.IBinder
import android.util.Log
import com.example.fitlocker.LockingActivity
import com.example.fitlocker.R
import com.github.kittinunf.fuel.Fuel
import com.github.kittinunf.fuel.android.extension.responseJson

class LockingService : NonStopIntentService("LockingService") {
    var threadIsTerminate = false


    private var mServiceReceiver: ServiceReceiver? = null
    private var activityManager: ActivityManager? = null
    val prefs by lazy { getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE) }


    private val homes: List<String>
        get() {
            val names = ArrayList<String>()
            val packageManager = this.packageManager
            val intent = Intent(Intent.ACTION_MAIN)
            intent.addCategory(Intent.CATEGORY_HOME)
            val resolveInfo = packageManager.queryIntentActivities(intent, PackageManager.MATCH_DEFAULT_ONLY)
            for (ri in resolveInfo) {
                names.add(ri.activityInfo.packageName)
            }
            return names
        }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }


    override fun onCreate() {
        super.onCreate()
        activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager

        mServiceReceiver = ServiceReceiver()
        val filter = IntentFilter()
        filter.addAction(Intent.ACTION_SCREEN_ON)
        filter.addAction(Intent.ACTION_SCREEN_OFF)
        filter.addAction(UNLOCK_ACTION)
        registerReceiver(mServiceReceiver, filter)

        threadIsTerminate = true

    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        super.onStart(intent!!, flags)
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        val notificationChannelId = "fitlocker"

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationChannel = NotificationChannel(notificationChannelId, "FitLocker", NotificationManager.IMPORTANCE_DEFAULT)

            // Configure the notification channel.
            notificationChannel.description = "FitLocker service"
            notificationChannel.enableLights(false)
            notificationChannel.enableVibration(false)
            notificationManager.createNotificationChannel(notificationChannel)
        }

        val notification = NotificationCompat.Builder(this, notificationChannelId)
                .setContentTitle("FitLocker")
                .setContentText("Protecting your apps")
                .setSmallIcon(R.drawable.ic_lock)
                .setAutoCancel(false)
                .setOngoing(true).build()
        startForeground(1,
                notification)
        return Service.START_STICKY
    }

    override fun onHandleIntent(intent : Intent) {
        checkData()
    }

    private fun checkData() {
        while (threadIsTerminate) {
            try {

                var packageName = getLauncherTopApp(this@LockingService, activityManager)
                if (packageName.isEmpty()) {
                    packageName = prefs.getString("flutter.lastPackage", "")
                }

                if (prefs.getBoolean("flutter.$packageName", false)
                        && prefs.getString("flutter.currentlyLocking", "")
                        != packageName) {
                    if (prefs.getString("flutter.lastPackage", "") != packageName) {
                        Log.v("ASDDD", "DUPA")
                        val res = Fuel.post("http://fitlocker.eu.ngrok.io/api/fit/allowance/start")
                                .header("Authorization" to "Bearer " + prefs.getString("flutter.token", ""))
                                .jsonBody("{ \"appType\" : \"androidApp\", \"appIdentifier\" : \"" + packageName + "\"  }")
                                .responseJson()
                        if (res.third.get().obj().getBoolean("allow")) {
                            prefs.edit().putBoolean("flutter.$packageName.unlocked", true).commit()
                        } else {
                            prefs.edit().putBoolean("flutter.$packageName.unlocked", false).commit()
                        }
                    }

                    if (prefs.getInt("lastPing", 0) > 30) {
                        prefs.edit().putInt("lastPing", 0).commit();
                        Fuel.post("http://fitlocker.eu.ngrok.io/api/fit/allowance/ping")

                                .header("Authorization" to "Bearer " + prefs.getString("flutter.token", ""))
                                .jsonBody("{ \"appType\" : \"androidApp\", \"appIdentifier\" : \"" + packageName + "\"  }")
                                .responseJson { _, _, result ->
                                    if (result.get().obj().getBoolean("allow")) {
                                        prefs.edit().putBoolean("flutter.$packageName.unlocked", true).commit()
                                    } else {
                                        prefs.edit().putBoolean("flutter.$packageName.unlocked", false).commit()
                                    }
                                    /* ... */
                                }
                    } else {
                        Log.v("asdasd", "tick " + prefs.getInt("lastPing", 0))
                        prefs.edit().putInt("lastPing", prefs.getInt("lastPing", 0) + 1).commit();

                    }

                    if (!prefs.getBoolean("flutter.$packageName.unlocked", false)) {
                        startActivity(LockingActivity.createIntent(this, packageName))
                    } else {
                    }
                }

                prefs.edit().putString("flutter.lastPackage", packageName).commit()
            } catch (e: Throwable) {
            }
            try {
                Thread.sleep(1500)
            } catch (e: InterruptedException) {
                e.printStackTrace()
            }

        }
    }

    inner class ServiceReceiver : BroadcastReceiver() {

        override fun onReceive(context: Context, intent: Intent) {
            val action = intent.action
        }
    }

    fun getLauncherTopApp(context: Context, activityManager: ActivityManager?): String {
        val sUsageStatsManager = context.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val endTime = System.currentTimeMillis()
        val beginTime = endTime - 10000
        var result = ""
        val event = UsageEvents.Event()
        val usageEvents = sUsageStatsManager.queryEvents(beginTime, endTime)
        while (usageEvents.hasNextEvent()) {
            usageEvents.getNextEvent(event)
            if (event.eventType == UsageEvents.Event.MOVE_TO_FOREGROUND) {
                result = event.packageName
            }
        }
        return if (!android.text.TextUtils.isEmpty(result)) {
            result
        } else ""

    }


    override fun onDestroy() {
        super.onDestroy()
        threadIsTerminate = false
        unregisterReceiver(mServiceReceiver)
    }

    companion object {

        val UNLOCK_ACTION = "UNLOCK_ACTION"
    }
}