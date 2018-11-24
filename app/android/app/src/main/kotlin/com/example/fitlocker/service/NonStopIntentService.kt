package com.example.fitlocker.service

import android.app.Service
import android.content.Intent
import android.os.*

abstract class NonStopIntentService(private val mName: String) : Service() {
    @Volatile
    private var mServiceLooper: Looper? = null
    @Volatile
    private var mServiceHandler: ServiceHandler? = null

    private inner class ServiceHandler(looper: Looper) : Handler(looper) {

        override fun handleMessage(msg: Message) {
            onHandleIntent(msg.obj as Intent)
        }
    }

    override fun onCreate() {
        super.onCreate()
        val thread = HandlerThread("IntentService[$mName]")
        thread.start()

        mServiceLooper = thread.looper
        mServiceHandler = ServiceHandler(mServiceLooper!!)
    }

    override fun onStart(intent: Intent, startId: Int) {
        val msg = mServiceHandler!!.obtainMessage()
        msg.arg1 = startId
        msg.obj = intent
        mServiceHandler!!.sendMessage(msg)
    }

    override fun onDestroy() {
        mServiceLooper!!.quit()
    }

    override fun onBind(intent: Intent): IBinder? {
        // TODO Auto-generated method stub
        return null
    }

    protected abstract fun onHandleIntent(intent: Intent)

}