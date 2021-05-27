package com.example.Alaswaq

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.TextView
import android.widget.Toast
import android.widget.Toolbar
import com.telr.mobile.sdk.activty.WebviewActivity
import com.telr.mobile.sdk.entity.response.status.StatusResponse
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel


class SuccessTransactionActivity : FlutterActivity() {
    private val mTextView: TextView? = null

    val TAG = "ChannelReproActivity"
    var status: StatusResponse? = null
    var channel: MethodChannel? = null


        override fun onCreate(savedInstanceState: Bundle?) {
            super.onCreate(savedInstanceState)
            setContentView(R.layout.activity_successtransaction)
            val toolbar = findViewById<Toolbar>(R.id.toolbar)
            toolbar.title = "Payment Successful"
            setActionBar(toolbar)
            val returnIntent = Intent()
            status =  intent.getParcelableExtra(WebviewActivity.PAYMENT_RESPONSE);
            val engine = FlutterEngineCache.getInstance().get("flutter_engine_id")
            engine?.let {
                //Set method call handler to that engine.
                MethodChannel(it.dartExecutor.binaryMessenger,
                        "host").invokeMethod("fromHostToClient", "success", object : MethodChannel.Result {
                    override fun success(o: Any?) {
                        finish()
                        Log.d("Results", o.toString())

                        Toast.makeText(applicationContext, "Results : Success", Toast.LENGTH_LONG).show()
                    }

                    override fun error(s: String, s1: String?, o: Any?) {
                        Toast.makeText(applicationContext, "Results : Error", Toast.LENGTH_LONG).show()
                    }

                    override fun notImplemented() {}
                })
            }
        }



//        override fun onStart() {
//
//            super.onStart()
//            val intent: Intent = intent
//            val status = intent.getParcelableExtra(WebviewActivity.PAYMENT_RESPONSE) as StatusResponse
//
//            val textView = findViewById<View>(R.id.text_payment_result) as TextView
//            textView.text = textView.text.toString() + " : " + status.trace
//            if (status.auth != null) {
//                status.auth.status // Authorisation status. A indicates an authorised transaction. H also indicates an authorised transaction, but where the transaction has been placed on hold. Any other value indicates that the request could not be processed.
//
//                status.auth.avs /* Result of the AVS check:
//                                            Y = AVS matched OK
//                                            P = Partial match (for example, post-code only)
//                                            N = AVS not matched
//                                            X = AVS not checked
//                                            E = Error, unable to check AVS */
//                status.auth.code // If the transaction was authorised, this contains the authorisation code from the card issuer. Otherwise it contains a code indicating why the transaction could not be processed.
//                status.auth.message // The authorisation or processing error message.
//                status.auth.ca_valid
//                status.auth.cardcode // Code to indicate the card type used in the transaction. See the code list at the end of the document for a list of card codes.
//                status.auth.cardlast4 // The last 4 digits of the card number used in the transaction. This is supplied for all payment types (including the Hosted Payment Page method) except for PayPal.
//                status.auth.cvv /* Result of the CVV check:
//                                           Y = CVV matched OK
//                                           N = CVV not matched
//                                           X = CVV not checked
//                                           E = Error, unable to check CVV */
//                status.auth.tranref //The payment gateway transaction reference allocated to this request.
//                Log.d("hany", status.auth.tranref)
//                Log.d("hanyyy", status.auth.status)
//                status.auth.cardfirst6 // The first 6 digits of the card number used in the transaction, only for version 2 is submitted in Tran -> Version
//                setTransactionDetails(status.auth.tranref, status.auth.cardlast4)
//
//            }
//        }
//
//        private fun setTransactionDetails(ref: String, last4: String) {
//            val sharedPref: SharedPreferences = applicationContext.getSharedPreferences("telr", Context.MODE_PRIVATE)
//            val editor: SharedPreferences.Editor = sharedPref.edit()
//            editor.putString("ref", ref)
//            editor.putString("last4", last4)
//            editor.commit()
//        }
//
//        fun closeWindow(view: View?) {
//
//            finish()
//        }
    }

