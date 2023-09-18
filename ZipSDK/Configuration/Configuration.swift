//
//  Configuration.swift
//  QuadPaySDK
//
//  Created by Petros Andreou on 02/05/2023.
//  Copyright © 2023 QuadPay. All rights reserved.
//

import Foundation

#if QUADPAY_SDK_DEVELOPMENT
let configPath = Bundle.qpResource.path(forResource: "ZipSDKDevelopment", ofType: "plist")
#else
let configPath = Bundle.qpResource.path(forResource: "ZipSDKProduction", ofType: "plist")
#endif


enum Configuration {
    
    enum Keys {
        enum PList {
            static let gatewayUrl = "GATEWAY_URL"
            static let quadPayJSUrl = "QUADPAY_JS_URL"
            static let cdnUrl = "CDN_URL"
        }
    }
    
    private static let infoDictionary: NSDictionary = {
        guard let configFilePath = configPath else {
            fatalError("ZipSDK Configuration file not found")
        }
        guard let dict = NSDictionary(contentsOfFile: configFilePath) else {
            fatalError("ZipSDK Configuration invalid")
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
    
    static let quadPayJSUrl: URL = {
        guard let quadpayJSUrlString = Configuration.infoDictionary[Keys.PList.quadPayJSUrl] as? String else{
            fatalError("ZipSDK JS URL is missing")
        }
        
        guard let url = URL(string: quadpayJSUrlString) else {
            fatalError("ZipSDK JS URL is invalid")
        }
        
        return url
    }()
    
    static let cdnUrl: URL = {
        guard let cdnUrlString = Configuration.infoDictionary[Keys.PList.quadPayJSUrl] as? String else{
            fatalError("CDN URL is missing")
        }
        
        guard let url = URL(string: cdnUrlString) else {
            fatalError("CDN URL is invalid")
        }
        
        return url
    }()
}

