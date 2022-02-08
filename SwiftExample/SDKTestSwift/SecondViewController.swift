//
//  SecondViewController.swift
//  SDKTestSwift
//
//  Created by Paul Sauer on 6/4/20.
//  Copyright © 2020 QuadPay. All rights reserved.
//

import UIKit
import QuadPaySDK

class SecondViewController: UIViewController, QuadPayVirtualCheckoutDelegate {
    func checkoutSuccessful(_ viewController: QuadPayVirtualCheckoutViewController, card: QuadPayCard, cardholder: QuadPayCardholder, customer: QuadPayCustomer, orderId: String) {
        viewController.dismiss();

        let alert = UIAlertController(title: "Virtual Checkout Success", message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true);
        // Use card + cardholder details here
        //  to complete purchase!
        //
        //
    }
    
    func checkoutCancelled(_ viewController: QuadPayVirtualCheckoutViewController, reason: String) {
        viewController.dismiss();
        let alert = UIAlertController(title: "Virtual Checkout Cancelled", message: reason, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true);
    }
    
    func didFailWithError(_ viewController: QuadPayVirtualCheckoutViewController, error: String) {
        viewController.dismiss();
        let alert = UIAlertController(title: "Virtual Checkout Error", message: error, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true);
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTouched(_ sender: Any) {
        NSLog("Button touched");
        let details = QuadPayCheckoutDetails();
        details.amount = NSDecimalNumber(string: "123.54", locale: nil);
        details.customerEmail = "test-swift@quadpay.com";
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
        let vc = QuadPayVirtualCheckoutViewController.start(delegate: self, details: details);
        self.present(vc, animated: true);
    }
}
