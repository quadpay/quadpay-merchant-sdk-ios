//
//  SegmentViewController.swift
//  SDKDemo
//
//  Created by Alex Lane on 9/30/22.
//  Copyright © 2022 QuadPay. All rights reserved.
//

import Foundation
import QuadPaySDK

class SegmentViewController: UIViewController {
    @IBAction func viewStandardWidgetButtonPresses(_ sender: UIButton) {
        NSLog("View Standard Widget button pressed")
        
        /*
         * This isn't working, but didn't want to waste the code and implementation. Once working, we can revisit to see how we can manually send events
         */
        //let analytics: SegmentAnalytics = SegmentAnalytics.initialize();
        //analytics.trackViewedStandardWidget();
        
        let alert = UIAlertController(title: "Segment Event Tracked", message: "The View Standard Widget event has been tracked (not working yey)", preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
        self.present(alert, animated: true);
    }
}
