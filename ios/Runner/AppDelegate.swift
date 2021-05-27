import UIKit
import Flutter
import TelrSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var mainCoordinator: AppCoordinator?
    
    var myarray = [String]()
    let KEY:String = "chLH4-WcPdf^g5D8" // TODO fill key
    let STOREID:String = "23888"  // TODO fill store id
    var paymentRequest:PaymentRequest?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//    let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
//    let tstChannel = FlutterMethodChannel(name:   "host",binaryMessenger: flutterViewController.binaryMessenger)
//    tstChannel.setMethodCallHandler({ [self](call: FlutterMethodCall, result:   FlutterResult) -> Void in
//       guard call.method == "goToLogin" else {
//       result(FlutterMethodNotImplemented)
//       return
//     }
////        UserDefaults.standard.setValue(call.arguments, forKey: "methodCahnnelArguments")
//        let controller = self.window.rootViewController as! FlutterViewController
//        self.linkNativeCode(controller: controller)
////     self.mainCoordinator?.start()
//    })
//      //
//       GeneratedPluginRegistrant.register(with: self)
//       let navigationController = UINavigationController(rootViewController: flutterViewController)
//       navigationController.isNavigationBarHidden = true
//       window?.rootViewController = navigationController
//       mainCoordinator = AppCoordinator(navigationController: navigationController)
//       window?.makeKeyAndVisible()
       //
    
    let controller = self.window.rootViewController as! FlutterViewController
            linkNativeCode(controller: controller)
            GeneratedPluginRegistrant.register(with: self)
    
       return super.application(application,     didFinishLaunchingWithOptions: launchOptions)
   
  }
    
    
   
    
    
}

extension AppDelegate {
    
    func linkNativeCode(controller: FlutterViewController) {
        let tstChannel = FlutterMethodChannel(name:   "host",binaryMessenger: controller.binaryMessenger)
            tstChannel.setMethodCallHandler({ [self](call: FlutterMethodCall, result:   FlutterResult) -> Void in
               guard call.method == "invokingfromdart" else {
               result(FlutterMethodNotImplemented)
               return
             }
                self.myarray = call.arguments as! [String]
                paymentRequest = preparePaymentRequestSaveCard()
                let telrController = TelrController()
                telrController.delegate = self
                telrController.paymentRequest = paymentRequest!
                let nav = UINavigationController(rootViewController: telrController)
        //        self.navigationController?.present(nav, animated: true, completion: nil)
        //        if let window = UIApplication.shared.windows.first?.rootViewController as? AppLandingNC {

                if let window = self.window, let rootViewController = window.rootViewController {
                      var currentController = rootViewController
                      while let presentedController = currentController.presentedViewController {
                          currentController = presentedController
                       }
                          currentController.present(nav, animated: true, completion: nil)
                  }
        //        UserDefaults.standard.setValue(call.arguments, forKey: "methodCahnnelArguments")
         
            })
       
//        }
       }
    
    private func getSavedData(key:String) -> String{
    
        let defaults = UserDefaults.standard
    
        return defaults.string(forKey: key) ?? ""

    }
    private func saveData(key:String, value:String){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    private func showAlert(message:String,type:String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           
            let alert = UIAlertController(title: type, message: message, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
       
//            self.present(alert, animated: true, completion: nil)
//            self.navigationController?.pushViewController(alert, animated: false)
        }
}
}
extension AppDelegate{
    
    
//
    
     private func preparePaymentRequest() -> PaymentRequest{
        let tamount = myarray[0]
        let taddress = myarray[1]
        let tcity = myarray[2]
        let tcountry = myarray[3]
        let tfirstName = myarray[4]
        let tlastName = myarray[5]
        let temail = myarray[6]
        let tphone = myarray[7]
        let tcartId = myarray[8]
        
        
         let paymentReq = PaymentRequest()
     
         paymentReq.key = KEY
     
         paymentReq.store = STOREID
//        paymentReq.store = tcartId
         paymentReq.appId = "123456789"
    
         paymentReq.appName = "Alaswaq"
     
         paymentReq.appUser = "123456"
     
         paymentReq.appVersion = "0.0.1"
     
         paymentReq.transTest = "0"
    
         paymentReq.transType = "auth"
    
         paymentReq.transClass = "paypage"
     
         paymentReq.transCartid = tcartId
     
         paymentReq.transDesc = "Android API"
     
         paymentReq.transCurrency = "AED"
     
//         paymentReq.transAmount = amountTxt.text!
        paymentReq.transAmount = tamount
     
         paymentReq.billingEmail = temail
     
         paymentReq.billingFName = tfirstName
     
         paymentReq.billingLName = tlastName
     
         paymentReq.billingTitle = "Mr"
     
         paymentReq.city = "Ras al Khaimah"
     
         paymentReq.country = "AE"
    
         paymentReq.region = taddress
     
         paymentReq.address = taddress
     
         paymentReq.language = "en"
     
         return paymentReq

     }


     private func preparePaymentRequestSaveCard() -> PaymentRequest{

        let tamount = myarray[0]
        let taddress = myarray[1]
        let tcity = myarray[2]
        let tcountry = myarray[3]
        let tfirstName = myarray[4]
        let tlastName = myarray[5]
        let temail = myarray[6]
        let tphone = myarray[7]
        let tcartId = myarray[8]
        print(tamount,taddress,  tfirstName, tcartId)
         let paymentReq = PaymentRequest()
     
         paymentReq.key = KEY
     
         paymentReq.store = STOREID
     
         paymentReq.appId = "123456789"
     
         paymentReq.appName = "Alaswaq"
     
         paymentReq.appUser = "123456"
     
         paymentReq.appVersion = "0.0.1"
     
         paymentReq.transTest = "0"
     
         paymentReq.transType = "paypage"
     
         paymentReq.transClass = "ecom"
     
         paymentReq.transCartid = tcartId
     
         paymentReq.transDesc = "Android API"
     
         paymentReq.transCurrency = "AED"
     
         paymentReq.billingFName = tfirstName
     
         paymentReq.billingLName = tlastName
     
         paymentReq.billingTitle = "Mr"
     
         paymentReq.city = "Ras al Khaimah"
     
         paymentReq.country = "AE"
     
         paymentReq.region = taddress
     
         paymentReq.address = taddress
     
//         paymentReq.transAmount = amountTxt.text!
        paymentReq.transAmount = tamount
     
         paymentReq.transFirstRef = self.getSavedData(key: "ref")
     
         paymentReq.transRef = self.getSavedData(key: "ref")
     
         paymentReq.billingEmail = temail
     
         paymentReq.language = "en"
     
         return paymentReq

     }
}




extension AppDelegate:TelrControllerDelegate{
    //Mark:- This method call when user click on back button
    func didPaymentCancel() {
        print("didPaymentCancel")
        self.showAlert(message: "didPaymentCancel", type: "Cancel")
    }
    
    //Mark:- This method call when payment done successfully
    func didPaymentSuccess(response: TelrResponseModel) {
        
        print("didPaymentSuccess")
           
        print("Trace \(String(describing: response.trace))")
        
        print("Status \(String(describing: response.status))")
        
        print("Avs \(String(describing: response.avs))")
        
        print("Code \(String(describing: response.code))")
        
        print("Ca_valid \(String(describing: response.ca_valid))")
        
        print("Card Code \(String(describing: response.cardCode))")
        
        print("Card Last4 \(String(describing: response.cardLast4))")
        
        print("CVV \(String(describing: response.cvv))")
        
        print("TranRef \(String(describing: response.tranRef))")
        
        
        //Mark:- Save card management it save only one card at time.
        //For save the card you need to store tranRef and when you are going to make second trans using thistranRef
        
//        if let ref = response.tranRef{
//            saveData(key: "ref", value: ref)
//        }
//        if let last4 = response.cardLast4{
//            saveData(key: "last4", value: last4)
//        }
//        self.displaySavedCard()
        
        self.showAlert(message: "didPaymentSuccess", type: "Success")
        
        
        
        let controller = self.window.rootViewController as! FlutterViewController
        let customChannel = FlutterMethodChannel(name: "host",
                                                binaryMessenger: controller.binaryMessenger)
        DispatchQueue.main.async {
            customChannel.invokeMethod("fromHostToClient", arguments: "success", result: {(r:Any?) -> () in
                print("result")
        })
    }
    
    }
    //Mark:- This method call when user click on cancel button and if payment get failed
    func didPaymentFail() {
        print("didPaymentFail")
//        self.showAlert(message: "didPaymentFail", type: "Fail")
        let controller = self.window.rootViewController as! FlutterViewController
        let customChannel = FlutterMethodChannel(name: "host",
                                                binaryMessenger: controller.binaryMessenger)
        DispatchQueue.main.async {
            customChannel.invokeMethod("fromHostToClient", arguments: "failed", result: {(r:Any?) -> () in
                print("result")
        })
    }
    }
    func didCancelPayment() {
        print("didCancelPayment")
        let controller = self.window.rootViewController as! FlutterViewController
        let customChannel = FlutterMethodChannel(name: "host",
                                                binaryMessenger: controller.binaryMessenger)
        DispatchQueue.main.async {
            customChannel.invokeMethod("fromHostToClient", arguments: "canceled", result: {(r:Any?) -> () in
                print("result")
        })
    }
    
    
}

}
