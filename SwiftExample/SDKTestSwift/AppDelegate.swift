//
//  AppDelegate.swift
//  SDKTestSwift
//
//  Created by Paul Sauer on 6/4/20.
//  Copyright © 2020 QuadPay. All rights reserved.
//

import UIKit
import QuadPaySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        QuadPay.sharedInstance().initialize(
            "44444444-4444-4444-4444-444444444444",
            environment:"development",
            locale:"US"
        );
        
        let instance = QuadPay.sharedInstance();
        
        NSLog("MerchantId: \(instance.merchantId)");
        NSLog("Environment: \(instance.environment)");
        NSLog("Locale: \(instance.locale)");
        NSLog("BaseUrl: \(instance.getBaseUrl())");
//        QuadPay.sharedInstance().initialize("asdf", environment: "asdf", locale: "asdf")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

