package com.example.Alaswaq;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.telr.mobile.sdk.activty.WebviewActivity;
import com.telr.mobile.sdk.entity.response.status.StatusResponse;

public class TranFailedActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tran_failed);
        android.widget.Toolbar toolbar = findViewById(R.id.toolbar);
        toolbar.setTitle("Payment Failed");
        setActionBar(toolbar);
    }

    @Override
    protected void onStart() {
        super.onStart();
        Intent intent = getIntent();
        Object object = intent.getParcelableExtra(WebviewActivity.PAYMENT_RESPONSE);
        TextView textView = (TextView) findViewById(R.id.text_payment_result2);

        if(object instanceof StatusResponse) {
            StatusResponse status = (StatusResponse) object;
            textView.setText(textView.getText() + " : " + status.getTrace() + " \n" + status.getAuth().getMessage());

            if (status.getAuth() != null)
            {
                status.getAuth().getStatus();
                status.getAuth().getAvs();
                status.getAuth().getCode();
                status.getAuth().getMessage();
                status.getAuth().getCa_valid();
                status.getAuth().getCardcode();
                status.getAuth().getCvv();
                status.getAuth().getTranref();
                status.getAuth().getAvs();
            }
        }else if (object instanceof String){
            String errorMessage = (String) object;
            textView.setText(textView.getText() + " : " + errorMessage);
        }
    }

    public void closeWindow(View view){
        this.finish();
    }
}