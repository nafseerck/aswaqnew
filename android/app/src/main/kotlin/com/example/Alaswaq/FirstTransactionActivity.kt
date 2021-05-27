package com.example.Alaswaq//
//import android.app.Application
//import android.content.Context
//import android.content.Intent
//import android.content.SharedPreferences
//import android.os.Bundle
//import android.util.Log
//import android.view.View
//import android.widget.TextView
//import android.widget.Toast
//import android.widget.Toolbar
//import androidx.annotation.NonNull
//import com.telr.mobile.sdk.activty.WebviewActivity
//import com.telr.mobile.sdk.entity.request.payment.*
//import com.telr.mobile.sdk.entity.response.status.StatusResponse
//import java.nio.ByteBuffer
//import java.util.*
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.embedding.engine.FlutterEngineCache
//import io.flutter.embedding.engine.dart.DartExecutor
//import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugin.platform.PlatformViewsController
//import io.flutter.plugins.GeneratedPluginRegistrant
//import java.math.BigInteger
//
//
//class FirstTransactionActivity: extends MultiDexApplication {
//
//    @Override
//    public void onCreate() {
//        super.onCreate();
//        //...
//        setupFlutter();
//    }
//
//    private void setupFlutter() {
//        // Instantiate your FlutterEngine.
//        FlutterEngine flutterEngine = new FlutterEngine(this);
//
//        // Pre-warm your FlutterEngine by starting Dart execution.
//        flutterEngine
//                .getDartExecutor()
//                .executeDartEntrypoint(
//                        DartExecutor.DartEntrypoint.createDefault()
//                );
//
//        FlutterEngineCache
//                .getInstance()
//                .put("my_engine_id", flutterEngine);
//    }
//}