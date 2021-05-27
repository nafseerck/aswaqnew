package com.example.Alaswaq;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.telr.mobile.sdk.activty.WebviewActivity;
import com.telr.mobile.sdk.entity.request.payment.Address;
import com.telr.mobile.sdk.entity.request.payment.App;
import com.telr.mobile.sdk.entity.request.payment.Billing;
import com.telr.mobile.sdk.entity.request.payment.MobileRequest;
import com.telr.mobile.sdk.entity.request.payment.Name;
import com.telr.mobile.sdk.entity.request.payment.Tran;

import java.math.BigInteger;
import java.util.List;
import java.util.Objects;
import java.util.Random;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import static com.example.Alaswaq.MainActivity.STORE_ID;
import static com.example.Alaswaq.MainActivity.isSecurityEnabled;

public class InitActivity extends FlutterActivity {


    //private static final String CHANNEL = "myChannel";
    public static final String CHANNEL = "host";
    public static final String KEY = "chLH4-WcPdf^g5D8";
    public static final String STORE_ID = "23888";
    public static final String EMAIL= "aniktest@gmail.com";
    public static final boolean isSecurityEnabled = false;
    String tamount ="0";
    String taddress ="address";
    String tcity ="city";
    String tcountry ="country";
    String tfirstName ="firstname";
    String tlastName ="lastname";
    String temail ="email";
    String tphone ="tphone";
    String tcartId ="tcartId";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // startTestActivity();
        new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
//                if(call.method.equals("invokingfromdart"))
//                {
                    //String data = call.method;
                    List<String> data1 = call.arguments();
                    tamount = data1.get(0);
                    taddress = data1.get(1);
                    tcity = data1.get(2);
                    tcountry = data1.get(3);
                    tfirstName = data1.get(4);
                    tlastName = data1.get(5);
                    temail = data1.get(6);
                    tphone = data1.get(7);
                    tcartId = data1.get(8);
                    result.success("Success From Dart");
                    //Toast.makeText(getApplicationContext(),data1.get(7).toString(),Toast.LENGTH_LONG).show();
                    //startNewActivity();
                    startTestActivity();
//                }
            }
        });
    }

    private void startTestActivity() {
        Intent intent = new Intent(this, TranSuccessActivity.class);
        startActivity(intent);
    }

    private MobileRequest getMobileRequest() {
        MobileRequest mobile = new MobileRequest();
        mobile.setStore(STORE_ID);
        mobile.setKey(KEY);
        App app = new App();
        app.setId("123456789");
        app.setName("Telr SDK DEMO");
        app.setUser("123456");
        app.setVersion("0.0.1");
        app.setSdk("123");
        mobile.setApp(app);
        Tran tran = new Tran();
        tran.setTest("1");
        tran.setType("auth");
        tran.setClazz("paypage");
        tran.setCartid(String.valueOf(new BigInteger(128, new Random())));
        tran.setDescription("Test Mobile API");
        tran.setCurrency("AED");
        tran.setAmount(tamount);
        tran.setLangauge("en");
        mobile.setTran(tran);
        Billing billing = new Billing();
        Address address = new Address();
        address.setCity(tcity);
        address.setCountry("United Arab Emirates");
        address.setRegion(tcity);
        address.setLine1(taddress);
        // (Optinal)
        billing.setAddress(address);
        Name name = new Name();
        name.setFirst(tfirstName);
        name.setLast(tlastName);
        name.setTitle("Mr");
        billing.setName(name);
        billing.setEmail(temail);
        billing.setPhone(tphone);
        mobile.setBilling(billing);
        return mobile;

    }

    private void startNewActivity() {
        Intent intent = new Intent(InitActivity.this, WebviewActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT);
        intent.putExtra(WebviewActivity.EXTRA_MESSAGE, getMobileRequest());
        intent.putExtra(WebviewActivity.SUCCESS_ACTIVTY_CLASS_NAME, "com.example.Alaswaq.TranSuccessActivity");
        intent.putExtra(WebviewActivity.FAILED_ACTIVTY_CLASS_NAME, "com.example.Alaswaq.TranFailedActivity");
        intent.putExtra(WebviewActivity.IS_SECURITY_ENABLED, isSecurityEnabled);
        startActivity(intent);
    }
}