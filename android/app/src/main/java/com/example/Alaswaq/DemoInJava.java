package com.example.Alaswaq;

import android.content.Context;
import android.util.Log;

import com.telr.mobile.sdk.TelrApplication;

/**
 * Created by staff on 10/30/17.
 */

public class DemoInJava extends TelrApplication {

    private static Context context;

    public void onCreate(){
        super.onCreate();
        Log.d("Demo","Context Started....");
        DemoInJava.context = getApplicationContext();
    }

    public static Context getContext(){
        return DemoInJava.context;
    }
}
