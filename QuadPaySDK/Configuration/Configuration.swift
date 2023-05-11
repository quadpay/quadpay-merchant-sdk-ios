//
//  Configuration.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 02/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

#if QUADPAY_SDK_DEVELOPMENT
let configPath = Bundle.qpResource.path(forResource: "QuadPaySDKDevelopment", ofType: "plist")
#else
let configPath = Bundle.qpResource.path(forResource: "QuadPaySDKProduction", ofType: "plist")
#endif


enum Configuration {
    
    enum Keys {
        enum PList {
            static let gatewayUrl = "GATEWAY_URL"
        }
    }
    
    private static let infoDictionary: NSDictionary = {
        guard let configFilePath = configPath else {
            fatalError("QuadPaySDK Configuration file not found")
        }
        guard let dict = NSDictionary(contentsOfFile: configFilePath) else {
            fatalError("QuadPaySDK Configuration invalid")
        }
        return dict
    }()
    
    static let gatewayUrl: URL = {
        guard let gatewayUrlString = Configuration.infoDictionary[Keys.PList.gatewayUrl] as? String else {
            fatalError("Gateway URL is missing")
        }
        
        guard let url = URL(string: gatewayUrlString) else {
            fatalError("Gateway URL is invalid")
        }
        
        return url
    }()
}

