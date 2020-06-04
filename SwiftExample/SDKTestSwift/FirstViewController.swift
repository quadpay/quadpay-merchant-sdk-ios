//
//  FirstViewController.swift
//  SDKTestSwift
//
//  Created by Paul Sauer on 6/4/20.
//  Copyright © 2020 QuadPay. All rights reserved.
//

import UIKit
import QuadPaySDK

class FirstViewController: UIViewController, QuadPayCheckoutDelegate {
    func checkoutSuccessful(_ viewController: QuadPayCheckoutViewController, orderId: String) {
        
    }
    
    func checkoutCancelled(_ viewController: QuadPayCheckoutViewController, reason: String) {
        
    }
    
    func didFailWithError(_ viewController: QuadPayCheckoutViewController, error: String) {
        
    }
    

    @IBAction func buttonTouch(_ sender: Any) {
        NSLog("Button touched");
        let details = QuadPayCheckoutDetails();
       details.amount = NSDecimalNumber(string: "123.54", locale: nil);
       details.customerPhoneNumber = "+11231231234";
       details.merchantReference = "qptest-234-1234";
       details.customerFirstName = "Test";
       details.customerLastName = "Client";
       details.customerAddressLine1 = "100 Any Street";
       details.customerAddressLine2 = "1st";
       details.customerCity = "New York";
       details.customerState = "NY";
       details.customerPostalCode = "10019";
       details.customerCountry = "US";
               
       let vc = QuadPayCheckoutViewController.start(delegate: self, details: details);
       self.present(vc, animated: true);
//       self.navigationController?.pushViewController(vc, animated: true);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }


}

