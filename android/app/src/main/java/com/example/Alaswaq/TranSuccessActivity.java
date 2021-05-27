package com.example.Alaswaq;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.telr.mobile.sdk.activty.WebviewActivity;
import com.telr.mobile.sdk.entity.response.status.StatusResponse;

import java.util.Objects;


import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;


public class TranSuccessActivity extends FlutterActivity {
    MethodChannel channel;
    Button clickMeButton;
    //private static final String CHANNEL = "com.flutter.epictest/epictest";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tran_success);
        android.widget.Toolbar toolbar = findViewById(R.id.toolbar);
        toolbar.setTitle("Payment Successful");
        setActionBar(toolbar);
        clickMeButton = findViewById(R.id.clickMeButton);
        channel = new MethodChannel(this.getFlutterView(), InitActivity.CHANNEL);
        clickMeButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                channel.invokeMethod("invokingfromdart", null, new MethodChannel.Result() {
//                    @Override
//                    public void success(Object o) {
//                        Log.d("Results", o.toString());
//                        Toast.makeText(getApplicationContext(), "Results : Success", Toast.LENGTH_LONG).show();
//                    }
//                    @Override
//                    public void error(String s, String s1, Object o) {
//                        Toast.makeText(getApplicationContext(), "Results : Failed", Toast.LENGTH_LONG).show();
//                    }
//                    @Override
//                    public void notImplemented() {
//                        Toast.makeText(getApplicationContext(), "Results : Not", Toast.LENGTH_LONG).show();
//                    }
//
//                });

            }
        });
    }

    public void closeWindow(View view){
        this.finish();
    }
}