package com.example.Alaswaq

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.TextView
import android.widget.Toast
import com.telr.mobile.sdk.activty.WebviewActivity
import com.telr.mobile.sdk.entity.response.status.StatusResponse
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class FailedTransactionActivity : AppCompatActivity() {
    private val mTextView: TextView? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_failedtransaction)
        val engine = FlutterEngineCache.getInstance().get("flutter_engine_id")
        engine?.let {
            //Set method call handler to that engine.
            MethodChannel(it.dartExecutor.binaryMessenger,
                    "host").invokeMethod("fromHostToClient", "failed", object : MethodChannel.Result {
                override fun success(o: Any?) {
                    finish()
                    Log.d("Results", o.toString())

                    Toast.makeText(applicationContext, "Results : failed", Toast.LENGTH_LONG).show()
                }

                override fun error(s: String, s1: String?, o: Any?) {
                    Toast.makeText(applicationContext, "Results : Error", Toast.LENGTH_LONG).show()
                }

                override fun notImplemented() {}
            })
        }
    }

    override fun onStart() {
        super.onStart()
        val intent = intent
        val `object`: Any = intent.getParcelableExtra(WebviewActivity.PAYMENT_RESPONSE)
        val textView = findViewById<View>(R.id.text_payment_result2) as TextView
        if (`object` is StatusResponse) {
            val status = `object`
            textView.text = """${textView.text} : ${status.trace} 
${status.auth.message}"""
            if (status.auth != null) {
                status.auth.status // Authorisation status. A indicates an authorised transaction. H also indicates an authorised transaction, but where the transaction has been placed on hold. Any other value indicates that the request could not be processed.
                status.auth.avs /* Result of the AVS check:
                                            Y = AVS matched OK
                                            P = Partial match (for example, post-code only)
                                            N = AVS not matched
                                            X = AVS not checked
                                            E = Error, unable to check AVS */
                status.auth.code // If the transaction was authorised, this contains the authorisation code from the card issuer. Otherwise it contains a code indicating why the transaction could not be processed.
                status.auth.message // The authorisation or processing error message.
                status.auth.ca_valid
                status.auth.cardcode // Code to indicate the card type used in the transaction. See the code list at the end of the document for a list of card codes.
                //  status.getAuth().getCardlast4();// The last 4 digits of the card number used in the transaction. This is supplied for all payment types (including the Hosted Payment Page method) except for PayPal.
                status.auth.cvv /* Result of the CVV check:
                                           Y = CVV matched OK
                                           N = CVV not matched
                                           X = CVV not checked
                                           E = Error, unable to check CVV */
                status.auth.tranref //The payment gateway transaction reference allocated to this request.
                status.auth.avs /* Result of the AVS check:
                                           Y = AVS matched OK
                                           P = Partial match (for example, post-code only)
                                           N = AVS not matched
                                           X = AVS not checked
                                           E = Error, unable to check AVS */
            }
        } else if (`object` is String) {
            textView.text = textView.text.toString() + " : " + `object`
        }
    }

    fun closeWindow(view: View?) {
        finish()
    }
}