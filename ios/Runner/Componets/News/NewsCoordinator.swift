//
//  NewsCoordinator.swift
//  Runner
//
//  Created by MAC on 27/12/2020.
//

import Foundation
import UIKit
import TelrSDK
import Flutter
final class NewsCoordinator: BaseCoordinator{
 weak var navigationController: UINavigationController?
 weak var delegate: NewsToAppCoordinatorDelegate?
    var coordinatorDelegate: NewsCoordinatorDelegate?
    let defaults = UserDefaults.standard
    var myarray = [String]()
    
    
    let KEY:String = "BwxtF~dq9L#xgWZb" // TODO fill key
    let STOREID:String = "21941"  // TODO fill store id
//    let EMAIL:String = "girish.spryox@gmail.com" // TODO fill email id
    
    var paymentRequest:PaymentRequest?
    
//    @IBOutlet var showCardBtn: UIButton!
//    @IBOutlet var cardSv: UIStackView!
//    @IBOutlet var amountTxt: UITextField!
//    @IBOutlet var cardTxt: UILabel!
    
//    @IBAction func showcardbtnPressed(_ sender: Any) {
//        
//        cardTxt.text = "**** **** **** " + getSavedData(key: "last4")
//        
//        if(cardSv.isHidden == true){
//            
//            cardSv.isHidden = false
//            
//            showCardBtn.setTitle("Hide",for: .normal)
//        
//        }else{
//            
//            cardSv.isHidden = true
//            
//            showCardBtn.setTitle("Show stored card",for: .normal)
//        }
//    }
//    @IBAction func payBtnPressed(_ sender: Any) {
//        
//        //Mark:-If you what change the back button as custome back button on navigation
//        let customBackButton = UIButton(type: .custom)
//        customBackButton.setTitle("Back", for: .normal)
//        customBackButton.setTitleColor(.black, for: .normal)
//
//        paymentRequest = preparePaymentRequest()
//        let telrController = TelrController()
//        telrController.delegate = self
//        telrController.customBackButton = customBackButton
//        telrController.paymentRequest = paymentRequest!
//        self.navigationController?.pushViewController(telrController, animated: true)
//
//
//    }
//    @IBAction func payBtn2Pressed(_ sender: Any) {
//        
//        paymentRequest = preparePaymentRequestSaveCard()
//        let telrController = TelrController()
//        telrController.delegate = self
//        telrController.paymentRequest = paymentRequest!
//        let nav = UINavigationController(rootViewController: telrController)
//        self.navigationController?.present(nav, animated: true, completion: nil)
//       
//    }

  

//    private func displaySavedCard() {
//        if(getSavedData(key: "last4").isEmpty){
//
//             showCardBtn.isHidden = true
//
//         }else{
//
//             showCardBtn.isHidden = false
//         }
//    }
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
            self.navigationController?.pushViewController(alert, animated: false)
        }
       
    }




 
override func start() {
    self.myarray = defaults.stringArray(forKey: "methodCahnnelArguments") ?? [String]()
    
 super.start()
// let storyboard = UIStoryboard(name: "News", bundle: nil)
// if let container =  storyboard.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController {
//  container.coordinatorDelegate = self
//    navigationController?.pushViewController(container, animated: false)
//}
//    self.displaySavedCard()
    paymentRequest = preparePaymentRequestSaveCard()
    let telrController = TelrController()
    telrController.delegate = self
    telrController.paymentRequest = paymentRequest!
    let nav = UINavigationController(rootViewController: telrController)
    self.navigationController?.present(nav, animated: true, completion: nil)
}
init(navigationController: UINavigationController?) {
  super.init()
  self.navigationController = navigationController
}
}
protocol NewsCoordinatorDelegate {
  func navigateToFlutter()
}
extension NewsCoordinator: NewsCoordinatorDelegate{
 func navigateToFlutter(){
   self.delegate?.navigateToFlutterViewController()
}
}


//Mark:- Payment Request Builder
extension NewsCoordinator:TelrControllerDelegate{
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
        
        if let ref = response.tranRef{
            saveData(key: "ref", value: ref)
        }
        if let last4 = response.cardLast4{
            saveData(key: "last4", value: last4)
        }
//        self.displaySavedCard()
        
//        self.showAlert(message: "didPaymentSuccess", type: "Success")
        
       
        
        
//        let flutterEngine = ((UIApplication.shared.delegate as? AppDelegate)?.flutterEngine)!;
//               let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil);
//             
//        let bmiDataChannel = FlutterMethodChannel(name: "com.flutter.epictest/epictest", binaryMessenger: flutterViewController.binaryMessenger)
//            
//        bmiDataChannel.invokeMethod("fromHostToClient", arguments: "success")
        
       
        
//        let controller = FlutterViewController(project: nil, nibName: nil, bundle: nil)
//        
////        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
           let customChannel = FlutterMethodChannel(name: "com.flutter.epictest/epictest",
                                                   binaryMessenger: FlutterViewController().binaryMessenger)
//        
//        
        DispatchQueue.main.async {
            customChannel.invokeMethod("fromHostToClient", arguments: "success", result: {(r:Any?) -> () in
//              // this will be called with r = "some string" (or FlutterMethodNotImplemented)
                self.coordinatorDelegate?.navigateToFlutter()
                   })
            
////            customChannel.invokeMethod("fromHostToClient", arguments: "success")
//            let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
//            appDelegate?.onPaymentSuccess()
           
//        let coordinator = FlutterCoordinator(navigationController: self.navigationController)
      
    
        }
    }
        
    

    //Mark:- This method call when user click on cancel button and if payment get failed
    func didPaymentFail() {
        print("didPaymentFail")
        self.showAlert(message: "didPaymentFail", type: "Fail")
    }
    
    func didCancelPayment() {
        print("didCancelPayment")
    }
    
}


//Mark:- Payment Request Builder
extension NewsCoordinator{
    
    
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
     
//         paymentReq.store = STOREID
        paymentReq.store = tcartId
         paymentReq.appId = "123456789"
    
         paymentReq.appName = "Alaswaq"
     
         paymentReq.appUser = "123456"
     
         paymentReq.appVersion = "0.0.1"
     
         paymentReq.transTest = "1"
    
         paymentReq.transType = "auth"
    
         paymentReq.transClass = "paypage"
     
         paymentReq.transCartid = String(arc4random())
     
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
     
         paymentReq.transTest = "1"
     
         paymentReq.transType = "paypage"
     
         paymentReq.transClass = "ecom"
     
         paymentReq.transCartid = String(arc4random())
     
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




