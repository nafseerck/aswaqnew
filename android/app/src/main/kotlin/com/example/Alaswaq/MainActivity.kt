package com.example.Alaswaq

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Toast
import androidx.annotation.NonNull
import com.telr.mobile.sdk.activty.WebviewActivity
import com.telr.mobile.sdk.entity.request.payment.*
import io.flutter.embedding.android.FlutterActivity


import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.math.BigInteger
import java.util.*

class MainActivity: FlutterActivity()
{
    var tamount ="0"
    var taddress ="address"
    var tcity ="city"
    var tcountry ="country"
    var tfirstName ="firstname"
    var tlastName ="lastname"
    var temail ="email"
    var tphone ="tphone"
    var tcartId ="tcartId"
    var stringName: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //setContentView(R.layout.activity_init)
        FlutterEngineCache
                .getInstance()
                .put("flutter_engine_id", flutterEngine)


        val engine = FlutterEngineCache.getInstance().get("flutter_engine_id")
        engine?.let {

            //Set method call handler to that engine.
            MethodChannel(it.dartExecutor.binaryMessenger,
                    "host").setMethodCallHandler { call, result ->
                Log.d("MainAct2", "Kill me")

                val data1 = call.arguments<List<String>>()
                Log.d("MainAct2", "Kill me2")
                tamount = data1.get(0).toString()
                taddress = data1.get(1).toString()
                tcity = data1.get(2).toString()
                tcountry = "AE"
                tfirstName = data1.get(4).toString()
                tlastName = data1.get(5).toString()
                temail = data1.get(6).toString()
                tphone = data1.get(7).toString()
                tcartId = data1.get(8).toString()
//                startAnotherActivity();
                startNewActivity()
            }

    }



//        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "host").setMethodCallHandler{ call, result ->
////            if (call.method == "methodNameItz")
////            {
//                //String data = call.method;
//                val data1 = call.arguments<List<String>>()
//
//                tamount = data1.get(0).toString()
//                taddress = data1.get(1).toString()
//                tcity = data1.get(2).toString()
//                tcountry = "AE"
//                tfirstName = data1.get(4).toString()
//                tlastName = data1.get(5).toString()
//                temail = data1.get(6).toString()
//                tphone = data1.get(7).toString()
//                tcartId = data1.get(8).toString()
////                startAnotherActivity();
//                startNewActivity()
//                //print("Money : "+tamount)
//                //Toast.makeText(applicationContext, "Address : "+taddress, Toast.LENGTH_LONG).show()
//                //startAnotherActivity();
//                //startNewActivity();
//
////            }
//
//        }

        /*val map = mapOf(0 to "methodNameItz", 1 to "methodNameItzzz")
        MethodChannel(
                flutterEngineInstance?.dartExecutor?.binaryMessenger,
                "myChannel"
        ).invokeMethod("methodNameItz", map)*/
    }


    private fun startAnotherActivity() {
        val intent = Intent(this@MainActivity, SuccessTransactionActivity::class.java)
        startActivity(intent)
        finishAndRemoveTask()
    }

    private fun startNewActivity() {
        val intent = Intent(this@MainActivity, WebviewActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT)
        intent.putExtra(WebviewActivity.EXTRA_MESSAGE, mobileRequest)
        intent.putExtra(WebviewActivity.SUCCESS_ACTIVTY_CLASS_NAME, "com.example.Alaswaq.SuccessTransactionActivity")
        intent.putExtra(WebviewActivity.FAILED_ACTIVTY_CLASS_NAME, "com.example.Alaswaq.FailedTransactionActivity")
        intent.putExtra(WebviewActivity.IS_SECURITY_ENABLED, MainActivity.isSecurityEnabled)
        startActivity(intent)
    }


    val mobileRequest: com.telr.mobile.sdk.entity.request.payment.MobileRequest
        get()
        {
            //Toast.makeText(applicationContext, "Address : "+taddress, Toast.LENGTH_LONG).show()
            val mobile = MobileRequest()
            mobile.store = MainActivity.STORE_ID // Store ID
            mobile.key = MainActivity.KEY // Authentication Key : The Authentication Key will be supplied by Telr as part of the Mobile API setup process after you request that this integration type is enabled for your account. This should not be stored permanently within the App.
            val app = App()
            app.id = "123456789" // Application installation ID
            app.name = "Alaswaq" // Application name
            app.user = "123456" // Application user ID : Your reference for the customer/user that is running the App. This should relate to their account within your systems.
            app.version = "0.0.1" // Application version
            app.sdk = "123"
            mobile.app = app
            val tran = Tran()
            tran.test = "0" // Test mode : Test mode of zero indicates a live transaction. If this is set to any other value the transaction will be treated as a test.
            tran.type = "auth" /* Transaction type
                                                            'auth'   : Seek authorisation from the card issuer for the amount specified. If authorised, the funds will be reserved but will not be debited until such time as a corresponding capture command is made. This is sometimes known as pre-authorisation.
                                                            'sale'   : Immediate purchase request. This has the same effect as would be had by performing an auth transaction followed by a capture transaction for the full amount. No additional capture stage is required.
                                                            'verify' : Confirm that the card details given are valid. No funds are reserved or taken from the card.
                                                        */
            tran.clazz = "paypage" // Transaction class only 'paypage' is allowed on mobile, which means 'use the hosted payment page to capture and process the card details'
            tran.cartid = tcartId //// Transaction cart ID : An example use of the cart ID field would be your own transaction or order reference.
            // tran.cartid = tcartId //// Transaction cart ID : An example use of the cart ID field would be your own transaction or order reference.
            tran.description = "Test Mobile API" // Transaction description
            tran.currency = "AED" // Transaction currency : Currency must be sent as a 3 character ISO code. A list of currency codes can be found at the end of this document. For voids or refunds, this must match the currency of the original transaction.
            tran.amount = tamount // Transaction amount : The transaction amount must be sent in major units, for example 9 dollars 50 cents must be sent as 9.50 not 950. There must be no currency symbol, and no thousands separators. Thedecimal part must be separated using a dot.
            // (Optinal) Previous transaction reference : The previous transaction reference is required for any continuous authority transaction. It must contain the reference that was supplied in the response for the original transaction.
            tran.langauge = "en" // (Optinal) default is en -> English
            mobile.tran = tran
            val billing = Billing()
            val address = Address()
            address.country="AE"
            address.city = "Ras-Al-Khaimah" // City : the minimum required details for a transaction to be processed
            //address.country = tcountry // Country : Country must be sent as a 2 character ISO code. A list of country codes can be found at the end of this document. the minimum required details for a transaction to be processed
            address.region = "Ras-Al-Khaimah" // Region
            address.line1 = taddress
            address.line2=taddress // Street address – line 1: the minimum required details for a transaction to be processed
            // Street address – line 1: the minimum required details for a transaction to be processed
            billing.address = address
            val name = Name()
            name.first = tfirstName // Forename : the minimum required details for a transaction to be processed
            name.last = tlastName // Surname : the minimum required details for a transaction to be processed
            name.title = "Mr" // Title
            billing.name = name
            billing.email = temail // TODO: Insert your email here : the minimum required details for a transaction to be processed.
            billing.phone = tphone
            mobile.billing = billing
            return mobile
        }

    private fun getMobileRequestWithContAuth(ref: String?): MobileRequest {
        val mobile = MobileRequest()
        mobile.store = MainActivity.STORE_ID // Store ID
        mobile.key = MainActivity.KEY // Authentication Key : The Authentication Key will be supplied by Telr as part of the Mobile API setup process after you request that this integration type is enabled for your account. This should not be stored permanently within the App.
        val app = App()
        app.id = "123456789" // Application installation ID
        app.name = "Telr SDK DEMO" // Application name
        app.user = "123456" // Application user ID : Your reference for the customer/user that is running the App. This should relate to their account within your systems.
        app.version = "0.0.1" // Application version
        app.sdk = "123"
        mobile.app = app
        val address = Address()
        address.country=taddress
        address.city = tcity // City : the minimum required details for a transaction to be processed
        //address.country = tcountry // Country : Country must be sent as a 2 character ISO code. A list of country codes can be found at the end of this document. the minimum required details for a transaction to be processed
        address.region = tcity // Region
        address.line1 = taddress
        address.line2=taddress// Street address – line 1: the minimum required details for a transaction to be processed
        address.line3=taddress
        val tran = Tran()
        tran.test = "0" // Test mode : Test mode of zero indicates a live transaction. If this is set to any other value the transaction will be treated as a test.
        tran.type = "sale"
        tran.clazz = "cont"
        tran.cartid = tcartId //// Transaction cart ID : An example use of the cart ID field would be your own transaction or order reference.
        tran.description = "Test Mobile API" // Transaction description
        tran.currency = "AED" // Transaction currency : Currency must be sent as a 3 character ISO code. A list of currency codes can be found at the end of this document. For voids or refunds, this must match the currency of the original transaction.
        tran.amount = tamount // Transaction amount : The transaction amount must be sent in major units, for example 9 dollars 50 cents must be sent as 9.50 not 950. There must be no currency symbol, and no thousands separators. Thedecimal part must be separated using a dot.
        tran.ref = ref // TODO Previous transaction reference : The previous transaction reference is required for any continuous authority transaction. It must contain the reference that was supplied in the response for the original transaction.
        mobile.tran = tran
        return mobile
    }
    companion object {
        private const val CHANNEL = "com.flutter.epictest/epictest"
        const val KEY = "chLH4-WcPdf^g5D8" // TODO: Insert your Key here
        const val STORE_ID = "23888" // TODO: Insert your Store ID here
        const val isSecurityEnabled = false // Mark false to test on simulator, True to test on actual device and Production
    }
    /* override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
         super.configureFlutterEngine(flutterEngine)
         flutterEngineInstance = flutterEngine
     }*/

}


/*class WidgetHelper {
    companion object  {
        private const val WIDGET_PREFERENCES_KEY = "widget_preferences"
        private const val WIDGET_HANDLE_KEY = "handle"

        const val CHANNEL = "com.example.app/widget"
        const val NO_HANDLE = -1L

        fun setHandle(context: Context, handle: Long) {
            context.getSharedPreferences(
                    WIDGET_PREFERENCES_KEY,
                    Context.MODE_PRIVATE
            ).edit().apply {
                putLong(WIDGET_HANDLE_KEY, handle)
                apply()
            }
        }

        fun getRawHandle(context: Context): Long {
            return context.getSharedPreferences(
                    WIDGET_PREFERENCES_KEY,
                    Context.MODE_PRIVATE
            ).getLong(WIDGET_HANDLE_KEY, NO_HANDLE)
        }
    }
}*/
