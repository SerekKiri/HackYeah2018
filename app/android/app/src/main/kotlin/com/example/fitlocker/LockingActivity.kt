package com.example.fitlocker

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.fitlocker.flutter.Flutter

class LockingActivity: AppCompatActivity() {
    companion object {
        fun createIntent(context: Context, packageName: String) : Intent {
            val intent = Intent(context, LockingActivity::class.java)
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_MULTIPLE_TASK)
            intent.putExtra(EXTRA_PACKAGENAME, packageName)
            return intent
        }

        val EXTRA_PACKAGENAME = "PACKAGE_NAME"
    }
    val prefs by lazy { getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE) }
    val lockPkgName by lazy { intent.getStringExtra(EXTRA_PACKAGENAME) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.mainscreen)
        val milis = System.currentTimeMillis() / 1000
        prefs.edit().putString("flutter.currentlyLocking", lockPkgName).commit()
        prefs.edit().putString("flutter.$packageName.lastLockTimestamp", milis.toString()).commit()

        val flutterFragment = Flutter.createFragment(lockPkgName)
        supportFragmentManager.beginTransaction().replace(R.id.content_view, flutterFragment).commit()
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        prefs.edit().putString("flutter.currentlyLocking", "").commit()

        if (!hasFocus) finish()
    }
}
