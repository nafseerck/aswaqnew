package com.example.Alaswaq

import android.content.Context
import android.util.Log
import com.telr.mobile.sdk.TelrApplication

class DemoApplication : TelrApplication() {
    override fun onCreate() {
        super.onCreate()
        Log.d("Demo", "Context Started....")
        context = applicationContext
    }

    companion object {
        var context: Context? = null
            private set
    }
}